function SBMLSpecies = Species_setUnits(SBMLSpecies, units)
%
%   Species_setUnits 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the units to be set
%
%             and returns 
%               the species with the units set
%
%       SBMLSpecies = Species_setUnits(SBMLSpecies, 'units')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setUnits(SBMLSpecies, units)', 'first argument must be an SBML species structure'));
elseif (~ischar(units))
    error(sprintf('Species_setUnits(SBMLSpecies, units)\n%s', 'second argument must be a string representing the units of the species'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Species_setUnits(SBMLSpecies, units)', 'no units field in a level 2 model'));    
end;

SBMLSpecies.units = units;
