function SBMLFunctionDefinition = FunctionDefinition_setName(SBMLFunctionDefinition, name)
%
%   FunctionDefinition_setName 
%             takes  1) an SBMLFunctionDefinition structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the functionDefinition with the name set
%
%       SBMLFunctionDefinition = FunctionDefinition_setName(SBMLFunctionDefinition, 'name')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_setName(SBMLFunctionDefinition, name)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(name))
    error(sprintf('FunctionDefinition_setName(SBMLFunctionDefinition, name)\n%s', 'second argument must be a string representing the name of the functionDefinition'));
end;

SBMLFunctionDefinition.name = name;