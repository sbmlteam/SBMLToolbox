function SBMLCompartmentVolumeRule = CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)
%
%   CompartmentVolumeRule_setCompartment 
%             takes  1) an SBMLCompartmentVolumeRule structure 
%             and    2) a string representing the compartment to be set
%
%             and returns 
%               the compartmentVolumeRule with the compartment set
%
%       SBMLCompartmentVolumeRule = CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, 'compartment')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_CompartmentVolumeRule(SBMLCompartmentVolumeRule, sbmlLevel))
    error(sprintf('%s\n%s', 'CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)', 'first argument must be an SBML compartmentVolumeRule structure'));
elseif (~ischar(compartment))
    error(sprintf('CompartmentVolumeRule_setCompartment(SBMLCompartmentVolumeRule, compartment)\n%s', 'second argument must be a string representing the compartment of the compartmentVolumeRule'));
end;

SBMLCompartmentVolumeRule.compartment = compartment;
