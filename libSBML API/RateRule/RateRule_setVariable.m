function SBMLRateRule = RateRule_setVariable(SBMLRateRule, variable)
%
%   RateRule_setVariable 
%             takes  1) an SBMLRateRule structure 
%             and    2) a string representing the variable to be set
%
%             and returns 
%               the rateRule with the variable set
%
%       SBMLRateRule = RateRule_setVariable(SBMLRateRule, 'variable')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    error(sprintf('%s\n%s', 'RateRule_setVariable(SBMLRateRule, variable)', 'first argument must be an SBML rateRule structure'));
elseif (~ischar(variable))
    error(sprintf('RateRule_setVariable(SBMLRateRule, variable)\n%s', 'second argument must be a string representing the variable of the rateRule'));
end;

SBMLRateRule.variable = variable;
