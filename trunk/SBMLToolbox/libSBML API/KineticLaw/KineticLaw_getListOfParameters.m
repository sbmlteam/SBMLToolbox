function parameters = KineticLaw_getListOfParameters(SBMLKineticLaw)
%
%   KineticLaw_getListOfParameters 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the array of parameter structures defined within the kineticLaw
%
%       parameters = KineticLaw_getListOfParameters(SBMLKineticLaw)

% get level
sbmlLevel = 2;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getListOfParameters(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

parameters = SBMLKineticLaw.parameter;