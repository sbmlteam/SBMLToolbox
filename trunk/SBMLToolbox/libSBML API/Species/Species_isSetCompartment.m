function value = Species_isSetCompartment(SBMLSpecies)
%
%   Species_isSetCompartment 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               1 if the compartment has been set 
%               0 otherwise
%
%       value = Species_isSetCompartment(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetCompartment(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

value = ~isempty(SBMLSpecies.compartment);
