function boundaryCondition = Species_getBoundaryCondition(SBMLSpecies)
%
%   Species_getBoundaryCondition 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the boundaryCondition of the species as an integer
%
%       boundaryCondition = Species_getBoundaryCondition(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getBoundaryCondition(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

boundaryCondition = SBMLSpecies.boundaryCondition;
