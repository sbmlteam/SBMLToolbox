function [compartmentVolumeRule, SBMLModel] = Model_createCompartmentVolumeRule(SBMLModel)
%
%   Model_createCompartmentVolumeRule 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the compartmentVolumeRule structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created compartmentVolumeRule
%
%       [compartmentVolumeRule, SBMLModel] = Model_createCompartmentVolumeRule(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createCompartmentVolumeRule(SBMLModel)', 'first argument must be an SBML model structure'));
end;

compartmentVolumeRule = CompartmentVolumeRule_create(SBMLModel.SBML_level);

SBMLModel = Model_addRule(SBMLModel, compartmentVolumeRule);
