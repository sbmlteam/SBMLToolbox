function timeUnits = KineticLaw_getTimeUnits(SBMLKineticLaw)
%
%   KineticLaw_getTimeUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the timeUnits of the kineticLaw as a string
%
%       timeUnits = KineticLaw_getTimeUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getTimeUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

timeUnits = SBMLKineticLaw.timeUnits;
