function SBMLSpecies = Species_setCompartment(SBMLSpecies, compartment)
%
%   Species_setCompartment 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the compartment to be set
%
%             and returns 
%               the species with the compartment set
%
%       SBMLSpecies = Species_setCompartment(SBMLSpecies, 'compartment')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setCompartment(SBMLSpecies, compartment)', 'first argument must be an SBML species structure'));
elseif (~ischar(compartment))
    error(sprintf('Species_setCompartment(SBMLSpecies, compartment)\n%s', 'second argument must be a string representing the compartment of the species'));
end;

SBMLSpecies.compartment = compartment;
