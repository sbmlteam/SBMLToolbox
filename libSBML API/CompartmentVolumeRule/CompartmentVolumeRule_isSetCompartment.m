function value = CompartmentVolumeRule_isSetCompartment(SBMLCompartmentVolumeRule)
%
%   CompartmentVolumeRule_isSetCompartment 
%             takes an SBMLCompartmentVolumeRule structure 
%
%             and returns 
%               1 if the compartment has been set 
%               0 otherwise
%
%       value = CompartmentVolumeRule_isSetCompartment(SBMLCompartmentVolumeRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    error(sprintf('%s\n%s', 'CompartmentVolumeRule_isSetCompartment(SBMLCompartmentVolumeRule)', 'argument must be an SBML compartmentVolumeRule structure'));
end;

value = ~isempty(SBMLCompartmentVolumeRule.compartment);
