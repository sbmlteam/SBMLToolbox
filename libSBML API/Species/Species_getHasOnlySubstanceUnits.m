function hasOnlySubstanceUnits = Species_getHasOnlySubstanceUnits(SBMLSpecies)
%
%   Species_getHasOnlySubstanceUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the hasOnlySubstanceUnits of the species as an integer
%
%       hasOnlySubstanceUnits = Species_getHasOnlySubstanceUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getHasOnlySubstanceUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getHasOnlySubstanceUnits(SBMLSpecies)', 'no hasOnlySubstanceUnits field in a level 1 model'));    
end;

hasOnlySubstanceUnits = SBMLSpecies.hasOnlySubstanceUnits;
