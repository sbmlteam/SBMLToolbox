function unit = UnitDefinition_getUnit(SBMLUnitDefinition, number)
%
%   UnitDefinition_getUnit 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) a number n
%
%             and returns 
%               the nth unit structure defined within the unitDefinition
%
%       unit = UnitDefinition_getUnit(SBMLUnitDefinition, number)

% get level
sbmlLevel = 2;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_getUnit(SBMLUnitDefinition, number)', 'first argument must be an SBML unitDefinition structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'UnitDefinition_getUnit(SBMLUnitDefinition, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLUnitDefinition.unit))
    unit = [];
else
    unit = SBMLUnitDefinition.unit(number);
end;
