function value = ModifierSpeciesReference_isSetSpecies(SBMLModifierSpeciesReference)
%
%   ModifierSpeciesReference_isSetSpecies 
%             takes an SBMLModifierSpeciesReference structure 
%
%             and returns 
%               1 if the species has been set 
%               0 otherwise
%
%       value = ModifierSpeciesReference_isSetSpecies(SBMLModifierSpeciesReference)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_ModifierSpeciesReference(SBMLModifierSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'ModifierSpeciesReference_isSetSpecies(SBMLModifierSpeciesReference)', 'argument must be an SBML modifierSpeciesReference structure'));
end;

value = ~isempty(SBMLModifierSpeciesReference.species);
