function constant = Species_getConstant(SBMLSpecies)
%
%   Species_getConstant 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the constant of the species as an integer
%
%       constant = Species_getConstant(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getConstant(SBMLSpecies)', 'argument must be an SBML species structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Species_getConstant(SBMLSpecies)', 'no constant field in a level 1 model'));    
end;

constant = SBMLSpecies.constant;
