function SBMLUnitDefinition = UnitDefinition_setId(SBMLUnitDefinition, id)
%
%   UnitDefinition_setId 
%             takes  1) an SBMLUnitDefinition structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the unitDefinition with the id set
%
%       SBMLUnitDefinition = UnitDefinition_setId(SBMLUnitDefinition, 'id')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_setId(SBMLUnitDefinition, id)', 'first argument must be an SBML unitDefinition structure'));
elseif (~ischar(id))
    error(sprintf('UnitDefinition_setId(SBMLUnitDefinition, id)\n%s', 'second argument must be a string representing the id of the unitDefinition'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_setId(SBMLUnitDefinition, id)', 'no id field in a level 1 model'));    
end;

SBMLUnitDefinition.id = id;
