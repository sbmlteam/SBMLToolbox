function value = Rule_isSetFormula(SBMLRule)
%
%   Rule_isSetFormula 
%             takes an SBMLRule structure 
%
%             and returns 
%               1 if the formula has been set 
%               0 otherwise
%
%       value = Rule_isSetFormula(SBMLRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Rule(SBMLRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Rule(SBMLRule, sbmlLevel))
    error(sprintf('%s\n%s', 'Rule_isSetFormula(SBMLRule)', 'argument must be an SBML rule structure'));
end;

value = ~isempty(SBMLRule.formula);
