function formula = Rule_getFormula(SBMLRule)
%
%   Rule_getFormula 
%             takes an SBMLRule structure 
%
%             and returns 
%               the formula of the rule as a string
%
%       formula = Rule_getFormula(SBMLRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Rule(SBMLRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Rule(SBMLRule, sbmlLevel))
    error(sprintf('%s\n%s', 'Rule_getFormula(SBMLRule)', 'argument must be an SBML rule structure'));
end;

formula = SBMLRule.formula;
