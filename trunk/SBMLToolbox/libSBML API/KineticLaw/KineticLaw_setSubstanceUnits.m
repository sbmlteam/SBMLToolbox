function SBMLKineticLaw = KineticLaw_setSubstanceUnits(SBMLKineticLaw, substanceUnits)
%
%   KineticLaw_setSubstanceUnits 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a string representing the substanceUnits to be set
%
%             and returns 
%               the kineticLaw with the substanceUnits set
%
%       SBMLKineticLaw = KineticLaw_setSubstanceUnits(SBMLKineticLaw, 'substanceUnits')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_setSubstanceUnits(SBMLKineticLaw, substanceUnits)', 'first argument must be an SBML kineticLaw structure'));
elseif (~ischar(substanceUnits))
    error(sprintf('KineticLaw_setSubstanceUnits(SBMLKineticLaw, substanceUnits)\n%s', 'second argument must be a string representing the substanceUnits of the kineticLaw'));
end;

SBMLKineticLaw.substanceUnits = substanceUnits;
