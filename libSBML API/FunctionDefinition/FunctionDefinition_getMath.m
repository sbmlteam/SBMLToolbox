function math = FunctionDefinition_getMath(SBMLFunctionDefinition)
%
%   FunctionDefinition_getMath 
%             takes an SBMLFunctionDefinition structure 
%
%             and returns 
%               the math of the functionDefinition as a string
%
%       math = FunctionDefinition_getMath(SBMLFunctionDefinition)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'FunctionDefinition_getMath(SBMLFunctionDefinition)', 'argument must be an SBML functionDefinition structure'));
end;

math = SBMLFunctionDefinition.math;