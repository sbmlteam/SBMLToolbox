function substanceUnits = Species_getSubstanceUnits(SBMLSpecies)
%
%   Species_getSubstanceUnits 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the substanceUnits of the species as a string
%
%       substanceUnits = Species_getSubstanceUnits(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getSubstanceUnits(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getSubstanceUnits(SBMLSpecies)', 'no substanceUnits field in a level 1 model'));    
end;

substanceUnits = SBMLSpecies.substanceUnits;
