function SBMLParameterRule = ParameterRule_setUnits(SBMLParameterRule, units)
%
%   ParameterRule_setUnits 
%             takes  1) an SBMLParameterRule structure 
%             and    2) a string representing the units to be set
%
%             and returns 
%               the parameterRule with the units set
%
%       SBMLParameterRule = ParameterRule_setUnits(SBMLParameterRule, 'units')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_ParameterRule(SBMLParameterRule, sbmlLevel))
    error(sprintf('%s\n%s', 'ParameterRule_setUnits(SBMLParameterRule, units)', 'first argument must be an SBML parameterRule structure'));
elseif (~ischar(units))
    error(sprintf('ParameterRule_setUnits(SBMLParameterRule, units)\n%s', 'second argument must be a string representing the units of the parameterRule'));
end;

SBMLParameterRule.units = units;
