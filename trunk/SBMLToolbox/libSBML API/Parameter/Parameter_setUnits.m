function SBMLParameter = Parameter_setUnits(SBMLParameter, units)
%
%   Parameter_setUnits 
%             takes  1) an SBMLParameter structure 
%             and    2) a string representing the units to be set
%
%             and returns 
%               the parameter with the units set
%
%       SBMLParameter = Parameter_setUnits(SBMLParameter, 'units')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_setUnits(SBMLParameter, units)', 'first argument must be an SBML parameter structure'));
elseif (~ischar(units))
    error(sprintf('Parameter_setUnits(SBMLParameter, units)\n%s', 'second argument must be a string representing the units of the parameter'));
end;

SBMLParameter.units = units;
