function SBMLModel = Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)
%
%   Model_addUnitDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLUnitDefinition structure
%
%             and returns 
%               the model with the unitDefinition added
%
%       SBMLModel = Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)', 'first argument must be an SBML model structure'));
elseif (~isSBML_UnitDefinition(SBMLUnitDefinition, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addUnitDefinition(SBMLModel, SBMLUnitDefinition)', 'second argument must be an SBML unitDefinition structure', sbmlLevel));
end;

numberUnitDefinitions = length(SBMLModel.unitDefinition);

SBMLModel.unitDefinition(numberUnitDefinitions+1) = SBMLUnitDefinition;

