function SBMLUnitDefinition = UnitDefinition_unsetName(SBMLUnitDefinition)
%
%   UnitDefinition_unsetName 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the unitDefinition with the name unset
%               (i.e. name = '')
%
%       SBMLUnitDefinition = UnitDefinition_unsetName(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_unsetName(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

SBMLUnitDefinition.name = '';
