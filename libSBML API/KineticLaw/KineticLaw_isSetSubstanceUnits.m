function value = KineticLaw_isSetSubstanceUnits(SBMLKineticLaw)
%
%   KineticLaw_isSetSubstanceUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               1 if the substanceUnits has been set 
%               0 otherwise
%
%       value = KineticLaw_isSetSubstanceUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_isSetSubstanceUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

value = ~isempty(SBMLKineticLaw.substanceUnits);
