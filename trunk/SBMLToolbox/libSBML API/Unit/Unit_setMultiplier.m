function SBMLUnit = Unit_setMultiplier(SBMLUnit, multiplier)
%
%   Unit_setMultiplier 
%             takes  1) an SBMLUnit structure 
%             and    2) the multiplier to be set
%
%             and returns 
%               the unit with the multiplier set
%
%       SBMLUnit = Unit_setMultiplier(SBMLUnit, multiplier)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setMultiplier(SBMLUnit, multiplier)', 'first argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_setMultiplier(SBMLUnit, multiplier)', 'no multiplier field in a level 1 model'));    
elseif (~isnumeric(multiplier))
    error(sprintf('%s\n%s', 'Unit_setMultiplier(SBMLUnit, multiplier)', 'second argument must be a number representing the multiplier'));        
end;

SBMLUnit.multiplier = multiplier;
