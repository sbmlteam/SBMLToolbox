function SBMLSpecies = Species_setConstant(SBMLSpecies, constant)
%
%   Species_setConstant 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the constant to be set
%
%             and returns 
%               the species with the constant set
%
%       SBMLSpecies = Species_setConstant(SBMLSpecies, constant)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setConstant(SBMLSpecies, constant)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(constant)) || (constant < 0) || (constant > 1))
    error(sprintf('Species_setConstant(SBMLSpecies, constant)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the species is constant'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_setConstant(SBMLSpecies, constant)', 'no constant field in a level 1 model'));    
end;

SBMLSpecies.constant = constant;
