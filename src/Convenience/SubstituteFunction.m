function Formula = SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)

%check arguments are appropriate

if (~ischar(OriginalFormula))
    error('SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)\n%s', 'first argument must be a character array');
elseif (~isSBML_FunctionDefinition(SBMLFunctionDefinition, 2))
    error('SubstituteFunction(OriginalFormula, SBMLFunctionDefinition)\n%s', 'second argument must be an SBML function definition structure');
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

% replace the arguments in function definition with those in the formula
FuncFormula = ElementsOfFuncDef{end};
for i = 1:NoElements
    FuncFormula = strrep(FuncFormula, ElementsOfFuncDef{i}, ElementsInFormula{i});
end;

Formula = strrep(OriginalFormula, OriginalFunction, FuncFormula);
