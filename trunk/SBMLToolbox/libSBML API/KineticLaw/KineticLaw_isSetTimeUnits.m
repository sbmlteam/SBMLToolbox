function value = KineticLaw_isSetTimeUnits(SBMLKineticLaw)
%
%   KineticLaw_isSetTimeUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               1 if the timeUnits has been set 
%               0 otherwise
%
%       value = KineticLaw_isSetTimeUnits(SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_isSetTimeUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

value = ~isempty(SBMLKineticLaw.timeUnits);
