function SBMLSpecies = Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)
%
%   Species_setSpatialSizeUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the spatialSizeUnits to be set
%
%             and returns 
%               the species with the spatialSizeUnits set
%
%       SBMLSpecies = Species_setSpatialSizeUnits(SBMLSpecies, 'spatialSizeUnits')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)', 'first argument must be an SBML species structure'));
elseif (~ischar(spatialSizeUnits))
    error(sprintf('Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)\n%s', 'second argument must be a string representing the spatialSizeUnits of the species'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setSpatialSizeUnits(SBMLSpecies, spatialSizeUnits)', 'no spatialSizeUnits field in a level 1 model'));    
end;

SBMLSpecies.spatialSizeUnits = spatialSizeUnits;
