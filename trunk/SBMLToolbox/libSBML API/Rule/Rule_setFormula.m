function SBMLRule = Rule_setFormula(SBMLRule, formula)
%
%   Rule_setFormula 
%             takes  1) an SBMLRule structure 
%             and    2) a string representing the formula to be set
%
%             and returns 
%               the rule with the formula set
%
%       SBMLRule = Rule_setFormula(SBMLRule, 'formula')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Rule(SBMLRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Rule(SBMLRule, sbmlLevel))
    error(sprintf('%s\n%s', 'Rule_setFormula(SBMLRule, formula)', 'first argument must be an SBML rule structure'));
elseif (~ischar(formula))
    error(sprintf('Rule_setFormula(SBMLRule, formula)\n%s', 'second argument must be a string representing the formula of the rule'));
end;

SBMLRule.formula = formula;
