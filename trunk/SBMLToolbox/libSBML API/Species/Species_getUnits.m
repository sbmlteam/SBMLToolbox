function units = Species_getUnits(SBMLSpecies)
%
%   Species_getUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the units of the species as a string
%
%       units = Species_getUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Species_getUnits(SBMLSpecies)', 'no units field in a level 2 model'));    
end;

units = SBMLSpecies.units;
