function species = SpeciesConcentrationRule_getSpecies(SBMLSpeciesConcentrationRule)
%
%   SpeciesConcentrationRule_getSpecies 
%             takes an SBMLSpeciesConcentrationRule structure 
%
%             and returns 
%               the species of the speciesConcentrationRule as a string
%
%       species = SpeciesConcentrationRule_getSpecies(SBMLSpeciesConcentrationRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesConcentrationRule_getSpecies(SBMLSpeciesConcentrationRule)', 'argument must be an SBML speciesConcentrationRule structure'));
end;

species = SBMLSpeciesConcentrationRule.species;
