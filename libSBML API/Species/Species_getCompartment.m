function compartment = Species_getCompartment(SBMLSpecies)
%
%   Species_getCompartment 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the compartment of the species as a string
%
%       compartment = Species_getCompartment(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getCompartment(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

compartment = SBMLSpecies.compartment;
