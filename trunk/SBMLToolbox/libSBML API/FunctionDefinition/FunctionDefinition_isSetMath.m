function value = FunctionDefinition_isSetMath(SBMLFunctionDefinition)
%
%   FunctionDefinition_isSetMath 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               1 if the math has been set 
%               0 otherwise
%
%       value = FunctionDefinition_isSetMath(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_isSetMath(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

value = ~isempty(SBMLFunctionDefinition.math);