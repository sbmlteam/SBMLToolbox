function value = RateRule_isSetVariable(SBMLRateRule)
%
%   RateRule_isSetVariable 
%             takes an SBMLRateRule structure 
%
%             and returns 
%               1 if the variable has been set 
%               0 otherwise
%
%       value = RateRule_isSetVariable(SBMLRateRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_RateRule(SBMLRateRule, sbmlLevel))
    error(sprintf('%s\n%s', 'RateRule_isSetVariable(SBMLRateRule)', 'argument must be an SBML rateRule structure'));
end;

value = ~isempty(SBMLRateRule.variable);
