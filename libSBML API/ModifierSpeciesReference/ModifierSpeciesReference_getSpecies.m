function species = ModifierSpeciesReference_getSpecies(SBMLModifierSpeciesReference)
%
%   ModifierSpeciesReference_getSpecies 
%             takes an SBMLModifierSpeciesReference structure 
%
%             and returns 
%               the species of the modifierSpeciesReference as a string
%
%       species = ModifierSpeciesReference_getSpecies(SBMLModifierSpeciesReference)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_ModifierSpeciesReference(SBMLModifierSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'ModifierSpeciesReference_getSpecies(SBMLModifierSpeciesReference)', 'argument must be an SBML modifierSpeciesReference structure'));
end;

species = SBMLModifierSpeciesReference.species;
