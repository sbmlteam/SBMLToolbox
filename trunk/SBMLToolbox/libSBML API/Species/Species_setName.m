function SBMLSpecies = Species_setName(SBMLSpecies, name)
%
%   Species_setName 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the species with the name set
%
%       SBMLSpecies = Species_setName(SBMLSpecies, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setName(SBMLSpecies, name)', 'first argument must be an SBML species structure'));
elseif (~ischar(name))
    error(sprintf('Species_setName(SBMLSpecies, name)\n%s', 'second argument must be a string representing the name of the species'));
end;

SBMLSpecies.name = name;
