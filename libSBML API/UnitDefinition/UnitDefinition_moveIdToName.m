function SBMLUnitDefinition = UnitDefinition_moveIdToName(SBMLUnitDefinition)
%
%   UnitDefinition_moveIdToName 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLUnitDefinition = UnitDefinition_moveIdToName(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_moveIdToName(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_moveIdToName(SBMLUnitDefinition)', 'no id field in a level 1 model'));    
end;

if (~UnitDefinition_isSetName(SBMLUnitDefinition))
    id = UnitDefinition_getId(SBMLUnitDefinition);
    SBMLUnitDefinition = UnitDefinition_setName(SBMLUnitDefinition, id);
    SBMLUnitDefinition = UnitDefinition_setId(SBMLUnitDefinition, '');
end;
