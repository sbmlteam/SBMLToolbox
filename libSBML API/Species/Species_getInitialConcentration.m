function initialConcentration = Species_getInitialConcentration(SBMLSpecies)
%
%   Species_getInitialConcentration 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the initialConcentration of the species as a double
%
%       initialConcentration = Species_getInitialConcentration(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getInitialConcentration(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getInitialConcentration(SBMLSpecies)', 'no initialConcentration field in a level 1 model'));    
end;

initialConcentration = SBMLSpecies.initialConcentration;
