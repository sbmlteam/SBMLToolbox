function SBMLFunctionDefinition = FunctionDefinition_setMath(SBMLFunctionDefinition, math)
%
%   FunctionDefinition_setMath 
%             takes  1) an SBMLFunctionDefinition structure 
%             and    2) a string representing the math to be set
%
%             and returns 
%               the functionDefinition with the math set
%
%       SBMLFunctionDefinition = FunctionDefinition_setMath(SBMLFunctionDefinition, 'math')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_setMath(SBMLFunctionDefinition, math)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(math))
    error(sprintf('FunctionDefinition_setMath(SBMLFunctionDefinition, math)\n%s', 'second argument must be a string representing the math of the functionDefinition'));
end;

SBMLFunctionDefinition.math = math;