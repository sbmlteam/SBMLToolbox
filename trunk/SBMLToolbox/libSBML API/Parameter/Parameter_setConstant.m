function SBMLParameter = Parameter_setConstant(SBMLParameter, constant)
%
%   Parameter_setConstant 
%             takes  1) an SBMLParameter structure 
%             and    2) an integer representing the constant to be set
%
%             and returns 
%               the parameter with the constant set
%
%       SBMLParameter = Parameter_setConstant(SBMLParameter, constant)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_setConstant(SBMLParameter, constant)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(constant)) || (constant < 0) || (constant > 1))
    error(sprintf('Parameter_setConstant(SBMLParameter, constant)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the parameter is constant'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Parameter_setConstant(SBMLParameter, constant)', 'no constant field in a level 1 model'));    
end;

SBMLParameter.constant = constant;
