function value = FunctionDefinition_isSetId(SBMLFunctionDefinition)
%
%   FunctionDefinition_isSetId 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = FunctionDefinition_isSetId(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_isSetId(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

value = ~isempty(SBMLFunctionDefinition.id);