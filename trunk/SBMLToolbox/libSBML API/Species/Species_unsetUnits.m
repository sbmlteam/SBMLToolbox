function SBMLSpecies = Species_unsetUnits(SBMLSpecies)
%
%   Species_unsetUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the units unset
%               (i.e. units = '')
%
%       SBMLSpecies = Species_unsetUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Species_unsetUnits(SBMLSpecies)', 'no units field in a level 2 model'));    
end;

SBMLSpecies.units = '';
