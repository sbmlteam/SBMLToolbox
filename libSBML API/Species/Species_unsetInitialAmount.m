function SBMLSpecies = Species_unsetInitialAmount(SBMLSpecies)
%
%   Species_unsetInitialAmount 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the initialAmount unset
%               (i.e. initialAmount = NAN)
%
%       SBMLSpecies = Species_unsetInitialAmount(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetInitialAmount(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

warning off all;
SBMLSpecies.initialAmount = 0/0;
SBMLSpecies.isSetInitialAmount = 0;
warning on all;
