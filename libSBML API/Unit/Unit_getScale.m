function scale = Unit_getScale(SBMLUnit)
%
%   Unit_getScale 
%             takes an SBMLUnit structure 
%
%             and returns 
%               the scale of the unit as an integer
%
%       scale = Unit_getScale(SBMLUnit)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s', 'Unit_getScale(SBMLUnit)', 'argument must be an SBML unit structure'));
end;

scale = SBMLUnit.scale;
