function SBMLSpecies = Species_moveIdToName(SBMLSpecies)
%
%   Species_moveIdToName 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLSpecies = Species_moveIdToName(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_moveIdToName(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_moveIdToName(SBMLSpecies)', 'no id field in a level 1 model'));    
end;

if (~Species_isSetName(SBMLSpecies))
    id = Species_getId(SBMLSpecies);
    SBMLSpecies = Species_setName(SBMLSpecies, id);
    SBMLSpecies = Species_setId(SBMLSpecies, '');
end;
