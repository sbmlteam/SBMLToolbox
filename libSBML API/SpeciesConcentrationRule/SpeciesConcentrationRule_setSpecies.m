function SBMLSpeciesConcentrationRule = SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)
%
%   SpeciesConcentrationRule_setSpecies 
%             takes  1) an SBMLSpeciesConcentrationRule structure 
%             and    2) a string representing the species to be set
%
%             and returns 
%               the speciesConcentrationRule with the species set
%
%       SBMLSpeciesConcentrationRule = SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, 'species')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)', 'first argument must be an SBML speciesConcentrationRule structure'));
elseif (~ischar(species))
    error(sprintf('SpeciesConcentrationRule_setSpecies(SBMLSpeciesConcentrationRule, species)\n%s', 'second argument must be a string representing the species of the speciesConcentrationRule'));
end;

SBMLSpeciesConcentrationRule.species = species;
