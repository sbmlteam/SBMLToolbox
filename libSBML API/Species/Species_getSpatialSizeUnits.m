function spatialSizeUnits = Species_getSpatialSizeUnits(SBMLSpecies)
%
%   Species_getSpatialSizeUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the spatialSizeUnits of the species as a string
%
%       spatialSizeUnits = Species_getSpatialSizeUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getSpatialSizeUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getSpatialSizeUnits(SBMLSpecies)', 'no spatialSizeUnits field in a level 1 model'));    
end;

spatialSizeUnits = SBMLSpecies.spatialSizeUnits;
