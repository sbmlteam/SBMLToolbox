function units = ParameterRule_getUnits(SBMLParameterRule)
%
%   ParameterRule_getUnits 
%             takes an SBMLParameterRule structure 
%
%             and returns 
%               the units of the parameterRule as a string
%
%       units = ParameterRule_getUnits(SBMLParameterRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_getUnits(SBMLParameterRule)', 'argument must be an SBML parameterRule structure'));
end;

units = SBMLParameterRule.units;
