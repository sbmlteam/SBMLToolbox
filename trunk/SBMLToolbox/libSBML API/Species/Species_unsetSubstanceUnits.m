function SBMLSpecies = Species_unsetSubstanceUnits(SBMLSpecies)
%
%   Species_unsetSubstanceUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the substanceUnits unset
%               (i.e. substanceUnits = '')
%
%       SBMLSpecies = Species_unsetSubstanceUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetSubstanceUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_unsetSubstanceUnits(SBMLSpecies)', 'no substanceUnits field in a level 1 model'));    
end;

SBMLSpecies.substanceUnits = '';
