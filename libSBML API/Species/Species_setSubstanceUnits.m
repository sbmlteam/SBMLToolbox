function SBMLSpecies = Species_setSubstanceUnits(SBMLSpecies, substanceUnits)
%
%   Species_setSubstanceUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the substanceUnits to be set
%
%             and returns 
%               the species with the substanceUnits set
%
%       SBMLSpecies = Species_setSubstanceUnits(SBMLSpecies, 'substanceUnits')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setSubstanceUnits(SBMLSpecies, substanceUnits)', 'first argument must be an SBML species structure'));
elseif (~ischar(substanceUnits))
    error(sprintf('Species_setSubstanceUnits(SBMLSpecies, substanceUnits)\n%s', 'second argument must be a string representing the substanceUnits of the species'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setSubstanceUnits(SBMLSpecies, substanceUnits)', 'no substanceUnits field in a level 1 model'));    
end;

SBMLSpecies.substanceUnits = substanceUnits;
