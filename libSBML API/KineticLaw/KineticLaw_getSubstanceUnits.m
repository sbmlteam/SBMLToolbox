function substanceUnits = KineticLaw_getSubstanceUnits(SBMLKineticLaw)
%
%   KineticLaw_getSubstanceUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the substanceUnits of the kineticLaw as a string
%
%       substanceUnits = KineticLaw_getSubstanceUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getSubstanceUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

substanceUnits = SBMLKineticLaw.substanceUnits;
