function [unitDefinition, SBMLModel] = Model_createUnitDefinition(SBMLModel)
%
%   Model_createUnitDefinition 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the unitDefinition structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created unitDefinition
%
%       [unitDefinition, SBMLModel] = Model_createUnitDefinition(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createUnitDefinition(SBMLModel)', 'first argument must be an SBML model structure'));
end;

unitDefinition = UnitDefinition_create(SBMLModel.SBML_level);

SBMLModel = Model_addUnitDefinition(SBMLModel, unitDefinition);
