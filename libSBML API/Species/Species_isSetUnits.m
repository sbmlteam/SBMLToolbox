function value = Species_isSetUnits(SBMLSpecies)
%
%   Species_isSetUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               1 if the units has been set 
%               0 otherwise
%
%       value = Species_isSetUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Species_isSetUnits(SBMLSpecies)', 'no units field in a level 2 model'));    
end;

value = ~isempty(SBMLSpecies.units);
