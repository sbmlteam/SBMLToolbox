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
%               with id = 'g' and math = 'lambda(x,x+0.5)' 
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
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->





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

OriginalFormula = LoseWhiteSpace(OriginalFormula);

startPoint = strfind(OriginalFormula, SBMLFunctionDefinition.id);
if (isempty(startPoint))
  Formula = '';
  return;
else
  funcName = '';
  j = startPoint;
  c = OriginalFormula(j);
  while (~strcmp(c, '('))
    funcName = strcat(funcName, c);
    j = j + 1;
    c = OriginalFormula(j);
  end;
  
  if (~isequal(funcName, SBMLFunctionDefinition.id))
    Formula = '';
    return;
  end;
end;

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
