function species = SpeciesReference_getSpecies(SBMLSpeciesReference)
%
%   SpeciesReference_getSpecies 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               the species of the speciesreference as a string
%
%       species = SpeciesReference_getSpecies(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_getSpecies(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
end;

species = SBMLSpeciesReference.species;
