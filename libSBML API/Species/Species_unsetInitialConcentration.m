function SBMLSpecies = Species_unsetInitialConcentration(SBMLSpecies)
%
%   Species_unsetInitialConcentration 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the initialConcentration unset
%               (i.e. initialConcentration = NAN)
%
%       SBMLSpecies = Species_unsetInitialConcentration(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetInitialConcentration(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_unsetInitialConcentration(SBMLSpecies)', 'no initialConcentration field in a level 1 model'));    
end;

warning off all;
SBMLSpecies.initialConcentration = 0/0;
SBMLSpecies.isSetInitialConcentration = 0;
warning on all;
