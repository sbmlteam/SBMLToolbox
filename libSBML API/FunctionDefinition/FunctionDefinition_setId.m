function SBMLFunctionDefinition = FunctionDefinition_setId(SBMLFunctionDefinition, id)
%
%   FunctionDefinition_setId 
%             takes  1) an SBMLFunctionDefinition structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the functionDefinition with the id set
%
%       SBMLFunctionDefinition = FunctionDefinition_setId(SBMLFunctionDefinition, 'id')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_setId(SBMLFunctionDefinition, id)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(id))
    error(sprintf('FunctionDefinition_setId(SBMLFunctionDefinition, id)\n%s', 'second argument must be a string representing the id of the functionDefinition'));
end;

SBMLFunctionDefinition.id = id;