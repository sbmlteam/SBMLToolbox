function SBMLParameter = Parameter_unsetUnits(SBMLParameter)
%
%   Parameter_unsetUnits 
%             takes an SBMLParameter structure 
%
%             and returns 
%               the parameter with the units unset
%               (i.e. units = '')
%
%       SBMLParameter = Parameter_unsetUnits(SBMLParameter)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s', 'Parameter_unsetUnits(SBMLParameter)', 'argument must be an SBML parameter structure'));
end;

SBMLParameter.units = '';
