function SBMLKineticLaw = KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)
%
%   KineticLaw_setTimeUnits 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a string representing the timeUnits to be set
%
%             and returns 
%               the kineticLaw with the timeUnits set
%
%       SBMLKineticLaw = KineticLaw_setTimeUnits(SBMLKineticLaw, 'timeUnits')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)', 'first argument must be an SBML kineticLaw structure'));
elseif (~ischar(timeUnits))
    error(sprintf('KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)\n%s', 'second argument must be a string representing the timeUnits of the kineticLaw'));
end;

SBMLKineticLaw.timeUnits = timeUnits;
