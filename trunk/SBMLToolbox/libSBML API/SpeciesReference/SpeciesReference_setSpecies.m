function SBMLSpeciesReference = SpeciesReference_setSpecies(SBMLSpeciesReference, species)
%
%   SpeciesReference_setSpecies 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) a string representing the species to be set
%
%             and returns 
%               the speciesreference with the species set
%
%       SBMLSpeciesReference = SpeciesReference_setSpecies(SBMLSpeciesReference, 'species')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_setSpecies(SBMLSpeciesReference, species)', 'first argument must be an SBML speciesreference structure'));
elseif (~ischar(species))
    error(sprintf('SpeciesReference_setSpecies(SBMLSpeciesReference, species)\n%s', 'second argument must be a string representing the species of the speciesreference'));
end;

SBMLSpeciesReference.species = species;
