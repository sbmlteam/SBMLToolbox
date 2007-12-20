function output = Rearrange(formula, x)
% Rearrange(formula, x)
%         takes a char array representing a formula
%         and   a char array representing a variable
%
% and returns the formula rearranged in terms of x
%
%--------------------------------------------------------------------------
% EXAMPLE:    output   =   Rearrange('X + Y - Z', 'X')
%                      =   '-Y+Z'
%--------------------------------------------------------------------------

%  Filename    : Rearrange.m
%  Description : rearranges the formula
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2005-01-12
%  Revision    : $Id$
%  Source      : $Source $
%
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%

f = LoseWhiteSpace(formula);

% if x is not in the formula just return the formula
if (~ismember(f, x))
  output = f;
  return;
end;


% if there are brackets these need to switch sides of the equation
% "intact" ie x+(y+z)  rearranges to x = -(y+z)
brackets = PairBrackets(f);

num = 0;
if (length(brackets)>1)
  [num, m] = size(brackets);
  for b=1:num
    group{b} = f(brackets(1): brackets(2));
    if (sum(ismember(group{b}, x)) > 0)
      error('Cannot deal with formula in this form');
    end;
    newvar{b} = strcat('var', num2str(b));
    f = strrep(f, group{b}, newvar{b});
  end;
end;

ops = '+-';
operators = ismember(f, ops);
OpIndex = find(operators == 1);

if(~isempty(OpIndex))
  %--------------------------------------------------
  % divide formula up into elements seperated by +/-
  if (OpIndex(1) == 1)
      % leading sign i.e. +x-y
      NumElements = length(OpIndex);
      j = 2;
      index = 2;
  else
      NumElements = length(OpIndex) + 1;
      j = 1;
      index = 1;
  end;


  for i = 1:NumElements-1

      element = '';

      while (j < OpIndex(index))
          element = strcat(element, f(j));
          j = j+1;
      end;
      Elements{i} = element;
      j = j + 1;
      index = index + 1;
  end;

  % get last element
  j = OpIndex(end)+1;
  element = '';

  while (j <= length(f))
      element = strcat(element, f(j));
      j = j+1;
  end;
  Elements{NumElements} = element;
else
  NumElements = 0;
  LHSElements{1} = f;
  LHSOps(1) = '+';
end;

%--------------------------------------------------
% check whether element contains x
% if does keep on lhs else move to rhs changing sign
output = '';
lhs = 1;
for i = 1:NumElements
    if (strfind(Elements{i}, x))
        % element contains x
        LHSElements{lhs} = Elements{i};

        if (OpIndex(1) == 1)
            LHSOps(lhs) = f(OpIndex(i));
        elseif (i == 1)
            LHSOps(lhs) = '+';
        else
            LHSOps(lhs) = f(OpIndex(i-1));
        end;

        lhs = lhs + 1;
    elseif (i == 1)
        % first element does not contain x

        if (OpIndex(1) == 1)
            if (strcmp(f(1), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;

        else
            % no sign so +
            output = strcat(output, '-');
        end;
        output = strcat(output, Elements{i});
    else
        % element not first and does not contain x
        if (OpIndex(1) == 1)
            if (strcmp(f(OpIndex(i)), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;

        else
           if (strcmp(f(OpIndex(i-1)), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;
        end;
        
        output = strcat(output, Elements{i});

   end;

end;

%------------------------------------------------------
% look at remaining LHS

for i = 1:length(LHSElements)
    [Mult{i}, invert(i)] = ParseElement(LHSElements{i}, x);
end;

operators = '+-/*^';

if (length(LHSElements) == 1)
    % only one element with x
    % check signs and multipliers
    if (strcmp(LHSOps(1), '-'))
        output = strcat('-(', output, ')');
    end;
    
    if (~strcmp(Mult{1}, '1'))
      if (isempty(output))
        if (invert(1) == 0)
          output = '0';
        end;
      else
        if (sum(ismember(Mult{1}, '/')) > 0)
          if (invert(1) == 0)
            output = strcat(output, '*(', Invert(Mult{1}, x), ')');
          else
            output = strcat('(', Mult{1}, ')*(', Invert(output, x), ')');
          end;
        else
          output = strcat(output, '/', Mult{1});
        end;
      end;
    end;
else
  if (isempty(output))
      if (invert == 0)
          output = '0';
      end;
  else
    divisor = '';
    if (strcmp(LHSOps(1), '+'))
        divisor = strcat(divisor, '(', Mult{1});
    else
         divisor = strcat(divisor, '(-', Mult{1});
    end;
    
    for i = 2:length(LHSElements)
        divisor = strcat(divisor, LHSOps(i), Mult{i});
    end;
    divisor = strcat(divisor, ')');
    if (sum(ismember(output, operators)) > 0)
      output = strcat('(', output, ')/', divisor);
    else
      output = strcat(output, '/', divisor);
    end;
  end;
end;
    
% replaced substituted vars
  for b=1:num
    output = strrep(output, newvar{b}, group{b});
  end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [multiplier, invert] = ParseElement(element, x)

if (strcmp(element, x))
    multiplier = '1';
    invert = 0;
    return;
end;

multipliers = strfind(element, '*');
if (length(multipliers) > 2)
  error('Too many multipliers');
end;

VarIndex = strfind(element, x);
if (isempty(multipliers))
  MultIndex = 1;
else
  if (length(multipliers) == 1)
    MultIndex = multipliers(1);
  else
    if (VarIndex > multipliers(2))
      MultIndex = multipliers(2);
    else
      MultIndex = multipliers(1);
    end;
  end;
end;
DivIndex = strfind(element, '/');

if (isempty(DivIndex))
    DivIndex = length(element);
end;

% if we have x/5*b
if (DivIndex < MultIndex)
  MultIndex = 1;
end;

if (VarIndex > DivIndex)
  [element, noinvert] = Invert(element, x);
  multiplier = ParseElement(element, x);
  if (noinvert == 0)
    multiplier = Invert(multiplier, x);
    invert = 1;
  else
    invert = 0;
  end;
  return;
end;
  

if ((DivIndex < MultIndex) ||(VarIndex < MultIndex) || (VarIndex > DivIndex)) 
    error('Cannot deal with formula in this form');
end;

n = '';
m = '';

for i = 1:MultIndex-1
  if (element(i) ~= '(' && element(i) ~= ')')
    n = strcat(n, element(i));
  end;
end;
if (isempty(n))
    n = '1';
end;

for i = DivIndex+1:length(element)
    m = strcat(m, element(i));
end;
if (isempty(m))
    m = '1';
end;

% if both m and n represenet numbers then they can be simplified

Num_n = str2num(n);
Num_m = str2num(m);

if (~isempty(Num_n) && ~isempty(Num_m))
    multiplier = num2str(Num_n/Num_m);
else
    if (strcmp(m, '1'))
        multiplier = n;
    else
    multiplier = strcat(n, '/', m);
    end;
end;
invert = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [y, noinvert] = Invert(formula, x)

% need to consider a/x*b
% which is really (b*a)/x
operators = '+-/*^';
noinvert = 0;

divider = strfind(formula, '/');
if (length(divider) > 1)
  error('Too many divide signs');
end;

if (isempty(divider))
  nominator = formula;
  denominator = '1';
else
  nominator = formula(1:divider-1);
  denominator = formula(divider+1:end);
end;
if (~IsSingleBracketed(denominator))
  multiplier = strfind(denominator, '*');
  
  if (length(multiplier) > 1)
    error('Too may multiplication signs');
  end;
  
  if (~isempty(multiplier))
    lhs = denominator(1:multiplier-1);
    rhs = denominator(multiplier+1:end);
    
      if (sum(ismember(nominator, operators)) > 0)
        if (IsSingleBracketed(nominator))
          nominator = strcat(nominator, '*', rhs);
        else
          nominator = strcat('(', nominator, ')*', rhs);
        end;
      else
        nominator = strcat(nominator, '*', rhs);
      end;
      denominator = lhs;
    
  end;
end;

% if x is now part of the nominator dont invert
if (strfind(nominator, x))
  if (sum(ismember(nominator, operators)) > 0)
    if (IsSingleBracketed(nominator))
      y = strcat(nominator, '/');
    else
      y = strcat ('(', nominator, ')/');
    end;
  else
    y = strcat(nominator, '/');
  end;
  if (sum(ismember(denominator, operators)) > 0)
    if (IsSingleBracketed(denominator))
      y = strcat(y, denominator);
    else
      y = strcat(y, '(', denominator, ')');
    end;
  else
    y = strcat(y, denominator);
  end;
  noinvert = 1;
else

  if (sum(ismember(denominator, operators)) > 0)
    if (IsSingleBracketed(denominator))
      y = strcat(denominator, '/');
    else
      y = strcat ('(', denominator, ')/');
    end;
  else
    y = strcat(denominator, '/');
  end;
  if (sum(ismember(nominator, operators)) > 0)
    if (IsSingleBracketed(nominator))
      y = strcat(y, nominator);
    else
      y = strcat(y, '(', nominator, ')');
    end;
  else
    y = strcat(y, nominator);
  end;
end;
%y = strcat('(', denominator, ')/(', nominator, ')');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function y = IsSingleBracketed(formula)

y = 0;
Open = strfind(formula, '(');

if (isempty(Open) || length(Open)> 1)
  return;
end;

if (Open ~= 1)
  return;
end;

len = length(formula);
Close = strfind(formula, ')');

if (length(Close)> 1)
  return;
end;

if (Close ~= len)
  return;
end;

y = 1;
