function SBMLKineticLaw = KineticLaw_unsetTimeUnits(SBMLKineticLaw)
%
%   KineticLaw_unsetTimeUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the kineticLaw with the timeUnits unset
%               (i.e. timeUnits = '')
%
%       SBMLKineticLaw = KineticLaw_unsetTimeUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_unsetTimeUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

SBMLKineticLaw.timeUnits = '';
