function value = ParameterRule_isSetUnits(SBMLParameterRule)
%
%   ParameterRule_isSetUnits 
%             takes an SBMLParameterRule structure 
%
%             and returns 
%               1 if the units has been set 
%               0 otherwise
%
%       value = ParameterRule_isSetUnits(SBMLParameterRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_isSetUnits(SBMLParameterRule)', 'argument must be an SBML parameterRule structure'));
end;

value = ~isempty(SBMLParameterRule.units);
