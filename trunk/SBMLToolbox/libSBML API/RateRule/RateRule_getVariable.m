function variable = RateRule_getVariable(SBMLRateRule)
%
%   RateRule_getVariable 
%             takes an SBMLRateRule structure 
%
%             and returns 
%               the variable of the rateRule as a string
%
%       variable = RateRule_getVariable(SBMLRateRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    error(sprintf('%s\n%s', 'RateRule_getVariable(SBMLRateRule)', 'argument must be an SBML rateRule structure'));
end;

variable = SBMLRateRule.variable;
