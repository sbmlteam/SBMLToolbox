function Formula = SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)
% SubstituteFunction 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLFunctionDefinition structure defining the formula
%       and returns 
%           the formula with the function substituted
%       or  an empty string if the id of the functionDefinition is not in the
%       originalFormula
%
%
%   EXAMPLE:
%           fD = SBMLFunmctionDefinition 
%               with id = 'g' and math = 'lambda(x,X+0.5)' 
%
%           formula = SubstituteFormula('g(y)', fD)
%           
%                   = 'y+0.5'
%
%           formula = SubstituteFormula('h(y)', fD)
%           
%                   = ''


%  Filename    :   SubstituteFunction.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   11-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
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
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):





%check arguments are appropriate
if (~isstruct(SBMLFunctionDefinition))
  error(sprintf('%s', ...
    'first argument must be an SBML functionDefinition structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLFunctionDefinition);

if (~ischar(OriginalFormula))
    error('SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)\n%s', 'first argument must be a character array containing the id of the function definition');
elseif (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel, sbmlVersion))
    error('SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)\n%s', 'second argument must be an SBML function definition structure');
end;

if (isempty(strfind(OriginalFormula, SBMLFunctionDefinition.id)))
  Formula = '';
  return;
end;

OriginalFormula = LoseWhiteSpace(OriginalFormula);
ElementsOfFuncDef = GetArgumentsFromLambdaFunction(SBMLFunctionDefinition.math);

% get the arguments of the application of the formula
StartFunctionInFormula = findstr(OriginalFormula, SBMLFunctionDefinition.id);

j = StartFunctionInFormula + length(SBMLFunctionDefinition.id) + 1;
c = OriginalFormula(j);
element = '';
NoElements = 1;
ElementsInFormula = {};
while (~strcmp(c, ')'))
    if (strcmp(c, ','))
        ElementsInFormula{NoElements} = element;
        element = '';
        NoElements = NoElements + 1;
    else
        element = strcat(element, c);
    end;
    
    j = j + 1;
    c = OriginalFormula(j);
end;
ElementsInFormula{NoElements} = element;
OriginalFunction = '';
for i = StartFunctionInFormula:j
    OriginalFunction = strcat(OriginalFunction, OriginalFormula(i));
end;

% check got right number
if (NoElements ~= length(ElementsOfFuncDef) - 1)
    error('SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)\n%s', 'mismatch in number of arguments between formula and function');
end;

% check that same arguments have not been used

for i = 1:NoElements
  for j = 1:NoElements
    if (strcmp(ElementsInFormula{i}, ElementsOfFuncDef{j}))
      newElem = strcat(ElementsInFormula{i}, '_new');
      ElementsOfFuncDef{j} = newElem;
      ElementsOfFuncDef{end} = strrep(ElementsOfFuncDef{end}, ElementsInFormula{i}, newElem);
    end;
  end;
end;
% replace the arguments in function definition with those in the formula
FuncFormula = '(';
FuncFormula = strcat(FuncFormula, ElementsOfFuncDef{end});
FuncFormula = strcat(FuncFormula, ')');
for i = 1:NoElements
    FuncFormula = strrep(FuncFormula, ElementsOfFuncDef{i}, ElementsInFormula{i});
end;

Formula = strrep(OriginalFormula, OriginalFunction, FuncFormula);
