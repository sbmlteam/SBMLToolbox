function units = UnitDefinition_getListOfUnits(SBMLUnitDefinition)
%
%   UnitDefinition_getListOfUnits 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               an array of SBML unit structures defined within the unitDefinition
%
%       units = UnitDefinition_getListOfUnits(SBMLUnitDefinition)

% get level
sbmlLevel = 2;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_getListOfUnits(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

units = SBMLUnitDefinition.unit;
