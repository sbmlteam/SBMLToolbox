function SBMLModifierSpeciesReference = ModifierSpeciesReference_setSpecies(SBMLModifierSpeciesReference, species)
%
%   ModifierSpeciesReference_setSpecies 
%             takes  1) an SBMLModifierSpeciesReference structure 
%             and    2) a string representing the species to be set
%
%             and returns 
%               the modifierSpeciesReference with the species set
%
%       SBMLModifierSpeciesReference = ModifierSpeciesReference_setSpecies(SBMLModifierSpeciesReference, 'species')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_ModifierSpeciesReference(SBMLModifierSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'ModifierSpeciesReference_setSpecies(SBMLModifierSpeciesReference, species)', 'first argument must be an SBML modifierSpeciesReference structure'));
elseif (~ischar(species))
    error(sprintf('ModifierSpeciesReference_setSpecies(SBMLModifierSpeciesReference, species)\n%s', 'second argument must be a string representing the species of the modifierSpeciesReference'));
end;

SBMLModifierSpeciesReference.species = species;
