function unitDefinition = UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)
%
%   UnitDefinition_addUnit 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) an SBMLUnit structure
%
%             and returns 
%               the unitDefinition with the unit added
%
%       unitDefinition = UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)

% get level
sbmlLevel = 2;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)', 'first argument must be an SBML unitDefinition structure'));
elseif (~isSBML_Unit(SBMLUnit, sbmlLevel))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'UnitDefinition_addUnit(SBMLUnitDefinition, SBMLUnit)', 'second argument must be an SBML unit structure', sbmlLevel));
end;

numberUnits = length(SBMLUnitDefinition.unit);

SBMLUnitDefinition.unit(numberUnits+1) = SBMLUnit;

unitDefinition = SBMLUnitDefinition;

