function id = FunctionDefinition_getId(SBMLFunctionDefinition)
%
%   FunctionDefinition_getId 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               the id of the functionDefinition as a string
%
%       id = FunctionDefinition_getId(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_getId(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

id = SBMLFunctionDefinition.id;