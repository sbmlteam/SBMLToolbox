function SBMLKineticLaw = KineticLaw_unsetSubstanceUnits(SBMLKineticLaw)
%
%   KineticLaw_unsetSubstanceUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the kineticLaw with the substanceUnits unset
%               (i.e. substanceUnits = '')
%
%       SBMLKineticLaw = KineticLaw_unsetSubstanceUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_unsetSubstanceUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

SBMLKineticLaw.substanceUnits = '';
