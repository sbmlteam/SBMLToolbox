function name = Species_getName(SBMLSpecies)
%
%   Species_getName 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the name of the species as a string
%
%       name = Species_getName(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getName(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

name = SBMLSpecies.name;
