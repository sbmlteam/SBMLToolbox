function name = FunctionDefinition_getName(SBMLFunctionDefinition)
%
%   FunctionDefinition_getName 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               the name of the functionDefinition as a string
%
%       name = FunctionDefinition_getName(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_getName(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

name = SBMLFunctionDefinition.name;