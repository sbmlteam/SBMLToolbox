function SBMLCompartment = Compartment_setOutside(SBMLCompartment, outside)
%
%   Compartment_setOutside 
%             takes  1) an SBMLCompartment structure 
%             and    2) a string representing the outside to be set
%
%             and returns 
%               the compartment with the outside set
%
%       SBMLCompartment = Compartment_setOutside(SBMLCompartment, 'outside')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setOutside(SBMLCompartment, outside)', 'first argument must be an SBML compartment structure'));
elseif (~ischar(outside))
    error(sprintf('Compartment_setOutside(SBMLCompartment, outside)\n%s', 'second argument must be a string representing the outside of the compartment'));
end;

SBMLCompartment.outside = outside;