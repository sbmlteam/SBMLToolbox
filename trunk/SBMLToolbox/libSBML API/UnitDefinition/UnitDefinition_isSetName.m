function value = UnitDefinition_isSetName(SBMLUnitDefinition)
%
%   UnitDefinition_isSetName 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = UnitDefinition_isSetName(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_isSetName(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

value = ~isempty(SBMLUnitDefinition.name);
