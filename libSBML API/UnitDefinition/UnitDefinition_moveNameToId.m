function SBMLUnitDefinition = UnitDefinition_moveNameToId(SBMLUnitDefinition)
%
%   UnitDefinition_moveNameToId 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLUnitDefinition = UnitDefinition_moveNameToId(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_moveNameToId(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_moveNameToId(SBMLUnitDefinition)', 'no id field in a level 1 model'));    
end;

if (~UnitDefinition_isSetId(SBMLUnitDefinition))
    name = UnitDefinition_getName(SBMLUnitDefinition);
    SBMLUnitDefinition = UnitDefinition_setId(SBMLUnitDefinition, name);
    SBMLUnitDefinition = UnitDefinition_setName(SBMLUnitDefinition, '');
end;
