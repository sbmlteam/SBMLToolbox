function SBMLSpecies = Species_unsetSpatialSizeUnits(SBMLSpecies)
%
%   Species_unsetSpatialSizeUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the spatialSizeUnits unset
%               (i.e. spatialSizeUnits = '')
%
%       SBMLSpecies = Species_unsetSpatialSizeUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetSpatialSizeUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_unsetSpatialSizeUnits(SBMLSpecies)', 'no spatialSizeUnits field in a level 1 model'));    
end;

SBMLSpecies.spatialSizeUnits = '';
