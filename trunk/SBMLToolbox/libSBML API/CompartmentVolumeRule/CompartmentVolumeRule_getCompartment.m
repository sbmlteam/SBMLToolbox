function compartment = CompartmentVolumeRule_getCompartment(SBMLCompartmentVolumeRule)
%
%   CompartmentVolumeRule_getCompartment 
%             takes an SBMLCompartmentVolumeRule structure 
%
%             and returns 
%               the compartment of the compartmentVolumeRule as a string
%
%       compartment = CompartmentVolumeRule_getCompartment(SBMLCompartmentVolumeRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    error(sprintf('%s\n%s', 'CompartmentVolumeRule_getCompartment(SBMLCompartmentVolumeRule)', 'argument must be an SBML compartmentVolumeRule structure'));
end;

compartment = SBMLCompartmentVolumeRule.compartment;
