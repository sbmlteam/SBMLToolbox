function SBMLSpecies = Species_setId(SBMLSpecies, id)
%
%   Species_setId 
%             takes  1) an SBMLSpecies structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the species with the id set
%
%       SBMLSpecies = Species_setId(SBMLSpecies, 'id')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setId(SBMLSpecies, id)', 'first argument must be an SBML species structure'));
elseif (~ischar(id))
    error(sprintf('Species_setId(SBMLSpecies, id)\n%s', 'second argument must be a string representing the id of the species'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setId(SBMLSpecies, id)', 'no id field in a level 1 model'));    
end;

SBMLSpecies.id = id;
