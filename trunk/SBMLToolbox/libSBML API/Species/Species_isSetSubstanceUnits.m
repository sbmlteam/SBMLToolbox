function value = Species_isSetSubstanceUnits(SBMLSpecies)
%
%   Species_isSetSubstanceUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               1 if the substanceUnits has been set 
%               0 otherwise
%
%       value = Species_isSetSubstanceUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetSubstanceUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_isSetSubstanceUnits(SBMLSpecies)', 'no substanceUnits field in a level 1 model'));    
end;

value = ~isempty(SBMLSpecies.substanceUnits);
