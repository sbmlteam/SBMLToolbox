function value = Species_isSetInitialConcentration(SBMLSpecies)
%
%   Species_isSetInitialConcentration 
%             takes an SBMLSpecies structure 
%
%             and returns the value of the isSetInitialConcentration field
%               1 if the initialConcentration has been set 
%               0 otherwise
%
%       value = Species_isSetInitialConcentration(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetInitialConcentration(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_isSetInitialConcentration(SBMLSpecies)', 'no initialConcentration field in a level 1 model'));    
end;

value = SBMLSpecies.isSetInitialConcentration;
