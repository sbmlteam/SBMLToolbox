function value = SpeciesReference_isSetSpecies(SBMLSpeciesReference)
%
%   SpeciesReference_isSetSpecies 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               1 if the species has been set 
%               0 otherwise
%
%       value = SpeciesReference_isSetSpecies(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_isSetSpecies(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
end;

value = ~isempty(SBMLSpeciesReference.species);
