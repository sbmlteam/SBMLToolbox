function kineticLaw = KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)
%
%   KineticLaw_addParameter 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) an SBMLParameter structure
%
%             and returns 
%               the kineticLaw with the parameter added
%
%       kineticLaw = KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)

% get level
sbmlLevel = 2;
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('%s\n%s', 'KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)', 'first argument must be an SBML kineticLaw structure'));
elseif (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)', 'second argument must be an SBML parameter structure', sbmlLevel));
end;

numberParameters = length(SBMLKineticLaw.parameter);

SBMLKineticLaw.parameter(numberParameters+1) = SBMLParameter;

kineticLaw = SBMLKineticLaw;

