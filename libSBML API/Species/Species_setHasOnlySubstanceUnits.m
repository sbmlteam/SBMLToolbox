function SBMLSpecies = Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)
%
%   Species_setHasOnlySubstanceUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the hasOnlySubstanceUnits to be set
%
%             and returns 
%               the species with the hasOnlySubstanceUnits set
%
%       SBMLSpecies = Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(hasOnlySubstanceUnits)) || (hasOnlySubstanceUnits < 0) || (hasOnlySubstanceUnits > 1))
    error(sprintf('Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is hasOnlySubstanceUnits'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setHasOnlySubstanceUnits(SBMLSpecies, hasOnlySubstanceUnits)', 'no hasOnlySubstanceUnits field in a level 1 model'));    
end;

SBMLSpecies.hasOnlySubstanceUnits = hasOnlySubstanceUnits;
