function SBMLUnit = Unit_setSpecies(SBMLUnit, species)
%
%   Unit_setSpecies 
%             takes  1) an SBMLUnit structure 
%             and    2) a string representing the species to be set
%
%             and returns 
%               the unit with the species set
%
%       SBMLUnit = Unit_setSpecies(SBMLUnit, 'species')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setSpecies(SBMLUnit, species)', 'first argument must be an SBML unit structure'));
elseif (~ischar(species))
    error(sprintf('Unit_setSpecies(SBMLUnit, species)\n%s', 'second argument must be a string representing the species of the unit'));
end;

SBMLUnit.species = species;
