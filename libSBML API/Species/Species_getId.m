function id = Species_getId(SBMLSpecies)
%
%   Species_getId 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the id of the species as a string
%
%       id = Species_getId(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getId(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getId(SBMLSpecies)', 'no id field in a level 1 model'));    
end;

id = SBMLSpecies.id;
