function SBMLUnit = Unit_setScale(SBMLUnit, scale)
%
%   Unit_setScale 
%             takes  1) an SBMLUnit structure 
%             and    2) an integer representing the scale to be set
%
%             and returns 
%               the unit with the scale set
%
%       SBMLUnit = Unit_setScale(SBMLUnit, scale)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_setScale(SBMLUnit, scale)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(scale))
    error(sprintf('Unit_setScale(SBMLUnit, scale)\n%s', 'second argument must be an integer representing the scale of the unit'));
end;

SBMLUnit.scale = int32(scale);
