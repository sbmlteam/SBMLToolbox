function value = UnitDefinition_isSetId(SBMLUnitDefinition)
%
%   UnitDefinition_isSetId 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = UnitDefinition_isSetId(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_isSetId(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'UnitDefinition_isSetId(SBMLUnitDefinition)', 'no id field in a level 1 model'));    
end;

value = ~isempty(SBMLUnitDefinition.id);
