function multiplier = Unit_getMultiplier(SBMLUnit)
%
%   Unit_getMultiplier 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the multiplier of the unit as a double
%
%       multiplier = Unit_getMultiplier(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_getMultiplier(SBMLUnit)', 'argument must be an SBML unit structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Unit_getMultiplier(SBMLUnit)', 'no multiplier field in a level 1 model'));    
end;

multiplier = SBMLUnit.multiplier;
