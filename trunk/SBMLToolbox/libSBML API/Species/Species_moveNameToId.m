function SBMLSpecies = Species_moveNameToId(SBMLSpecies)
%
%   Species_moveNameToId 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLSpecies = Species_moveNameToId(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_moveNameToId(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_moveNameToId(SBMLSpecies)', 'no id field in a level 1 model'));    
end;

if (~Species_isSetId(SBMLSpecies))
    name = Species_getName(SBMLSpecies);
    SBMLSpecies = Species_setId(SBMLSpecies, name);
    SBMLSpecies = Species_setName(SBMLSpecies, '');
end;
