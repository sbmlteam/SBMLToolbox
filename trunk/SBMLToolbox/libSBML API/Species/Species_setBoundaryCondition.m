function SBMLSpecies = Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)
%
%   Species_setBoundaryCondition 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the boundaryCondition to be set
%
%             and returns 
%               the species with the boundaryCondition set
%
%       SBMLSpecies = Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(boundaryCondition)) || (boundaryCondition < 0) || (boundaryCondition > 1))
    error(sprintf('Species_setBoundaryCondition(SBMLSpecies, boundaryCondition)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is boundaryCondition'));
end;

SBMLSpecies.boundaryCondition = boundaryCondition;
