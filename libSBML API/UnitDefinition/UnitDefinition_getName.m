function name = UnitDefinition_getName(SBMLUnitDefinition)
%
%   UnitDefinition_getName 
%             takes an SBMLUnitDefinition structure 
%
%             and returns 
%               the name of the unitDefinition as a string
%
%       name = UnitDefinition_getName(SBMLUnitDefinition)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s', 'UnitDefinition_getName(SBMLUnitDefinition)', 'argument must be an SBML unitDefinition structure'));
end;

name = SBMLUnitDefinition.name;
