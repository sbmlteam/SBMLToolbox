function SBMLParameterRule = ParameterRule_unsetUnits(SBMLParameterRule)
%
%   ParameterRule_setUnits 
%             takes  an SBMLParameterRule structure 
%
%             and returns 
%               the parameterRule with the units unset
%                   i.e. units = ''
%
%       SBMLParameterRule = ParameterRule_unsetUnits(SBMLParameterRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_unsetUnits(SBMLParameterRule)', 'argument must be an SBML parameterRule structure'));
end;

SBMLParameterRule.units = units;
