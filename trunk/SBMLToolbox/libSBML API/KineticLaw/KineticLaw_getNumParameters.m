function number = KineticLaw_getNumParameters(SBMLKineticLaw)
%
%   KineticLaw_getNumParameters 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the number of parameter structures defined within the kineticLaw
%
%       number = KineticLaw_getNumParameters(SBMLKineticLaw)

% get level
sbmlLevel = 2;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_getNumParameters(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

number = 0;

if (~isempty(SBMLKineticLaw.parameter))
    number = length(SBMLKineticLaw.parameter);
end;
