function SBMLSpecies = Species_unsetName(SBMLSpecies)
%
%   Species_unsetName 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the name unset
%               (i.e. name = '')
%
%       SBMLSpecies = Species_unsetName(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetName(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

SBMLSpecies.name = '';
