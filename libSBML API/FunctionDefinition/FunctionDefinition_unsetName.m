function SBMLFunctionDefinition = FunctionDefinition_unsetName(SBMLFunctionDefinition)
%
%   FunctionDefinition_unsetName 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               the functionDefinition with the name unset
%               (i.e. name = '')
%
%       SBMLFunctionDefinition = FunctionDefinition_unsetName(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_unsetName(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

SBMLFunctionDefinition.name = '';