function id = UnitDefinition_getId(SBMLUnitDefinition)
%
%   UnitDefinition_getId 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the id of the unitDefinition as a string
%
%       id = UnitDefinition_getId(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_getId(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_getId(SBMLUnitDefinition)', 'no id field in a level 1 model'));    
end;

id = SBMLUnitDefinition.id;
