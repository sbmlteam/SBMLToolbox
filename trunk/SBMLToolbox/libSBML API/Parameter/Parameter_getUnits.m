function units = Parameter_getUnits(SBMLParameter)
%
%   Parameter_getUnits 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the units of the parameter as a string
%
%       units = Parameter_getUnits(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_getUnits(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

units = SBMLParameter.units;
