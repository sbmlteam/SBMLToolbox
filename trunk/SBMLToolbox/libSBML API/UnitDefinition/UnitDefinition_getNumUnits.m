function number = UnitDefinition_getNumUnits(SBMLUnitDefinition)
%
%   UnitDefinition_getNumUnits 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the number of unit structures defined within the unitDefinition
%
%       number = UnitDefinition_getNumUnits(SBMLUnitDefinition)

% get level
sbmlLevel = 2;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_getNumUnits(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

number = 0;

if (~isempty(SBMLUnitDefinition.unit))
    number = length(SBMLUnitDefinition.unit);
end;
