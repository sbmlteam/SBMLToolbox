function initialAmount = Species_getInitialAmount(SBMLSpecies)
%
%   Species_getInitialAmount 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the initialAmount of the species as a double
%
%       initialAmount = Species_getInitialAmount(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getInitialAmount(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

initialAmount = SBMLSpecies.initialAmount;
