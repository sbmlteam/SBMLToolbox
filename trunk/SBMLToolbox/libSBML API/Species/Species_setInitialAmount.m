function SBMLSpecies = Species_setInitialAmount(SBMLSpecies, initialAmount)
%
%   Species_setInitialAmount 
%             takes  1) an SBMLSpecies structure 
%             and    2) a double representing the initialAmount to be set
%
%             and returns 
%               the species with the initialAmount set
%
%       SBMLSpecies = Species_setInitialAmount(SBMLSpecies, initialAmount)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setInitialAmount(SBMLSpecies, initialAmount)', 'first argument must be an SBML species structure'));
elseif(~isnumeric(initialAmount))
    error(sprintf('%s\n%s', 'Species_setInitialAmount(SBMLSpecies, initialAmount)', 'second argument must be a number representing the initialAmount')); 
end;

SBMLSpecies.initialAmount = initialAmount;
SBMLSpecies.isSetInitialAmount = 1;

warning off all;
SBMLSpecies.initialConcentration = 0/0;
SBMLSpecies.isSetInitialConcentration = 0;
warning on all;