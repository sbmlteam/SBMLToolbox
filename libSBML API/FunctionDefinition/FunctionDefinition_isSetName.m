function value = FunctionDefinition_isSetName(SBMLFunctionDefinition)
%
%   FunctionDefinition_isSetName 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = FunctionDefinition_isSetName(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_isSetName(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

value = ~isempty(SBMLFunctionDefinition.name);