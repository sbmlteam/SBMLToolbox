function SBMLUnitDefinition = UnitDefinition_setName(SBMLUnitDefinition, name)
%
%   UnitDefinition_setName 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the unitDefinition with the name set
%
%       SBMLUnitDefinition = UnitDefinition_setName(SBMLUnitDefinition, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_setName(SBMLUnitDefinition, name)', 'first argument must be an SBML unitDefinition structure'));
elseif (~ischar(name))
    error(sprintf('UnitDefinition_setName(SBMLUnitDefinition, name)\n%s', 'second argument must be a string representing the name of the unitDefinition'));
end;

SBMLUnitDefinition.name = name;
