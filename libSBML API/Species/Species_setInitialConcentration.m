function SBMLSpecies = Species_setInitialConcentration(SBMLSpecies, initialConcentration)
%
%   Species_setInitialConcentration 
%             takes  1) an SBMLSpecies structure 
%             and    2) a double representing the initialConcentration to be set
%
%             and returns 
%               the species with the initialConcentration set
%
%       SBMLSpecies = Species_setInitialConcentration(SBMLSpecies, initialConcentration)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, initialConcentration)', 'first argument must be an SBML species structure'));
elseif(~isnumeric(initialConcentration))
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, initialConcentration)', 'second argument must be a number representing the initialConcentration')); 
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setInitialConcentration(SBMLSpecies, ,initialConcentration)', 'no initialConcentration field in a level 1 model'));    
end;

SBMLSpecies.initialConcentration = initialConcentration;
SBMLSpecies.isSetInitialConcentration = 1;

warning off all;
SBMLSpecies.initialAmount = 0/0;
SBMLSpecies.isSetInitialAmount = 0;
warning on all;