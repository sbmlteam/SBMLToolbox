function value = SpeciesConcentrationRule_isSetSpecies(SBMLSpeciesConcentrationRule)
%
%   SpeciesConcentrationRule_isSetSpecies 
%             takes an SBMLSpeciesConcentrationRule structure 
%
%             and returns 
%               1 if the species has been set 
%               0 otherwise
%
%       value = SpeciesConcentrationRule_isSetSpecies(SBMLSpeciesConcentrationRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesConcentrationRule(SBMLSpeciesConcentrationRule, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesConcentrationRule_isSetSpecies(SBMLSpeciesConcentrationRule)', 'argument must be an SBML speciesConcentrationRule structure'));
end;

value = ~isempty(SBMLSpeciesConcentrationRule.species);
