function [parameterRule, SBMLModel] = Model_createParameterRule(SBMLModel)
%
%   Model_createParameterRule 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the parameterRule structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created parameterRule
%
%       [parameterRule, SBMLModel] = Model_createParameterRule(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createParameterRule(SBMLModel)', 'first argument must be an SBML model structure'));
end;

parameterRule = ParameterRule_create(SBMLModel.SBML_level);

SBMLModel = Model_addRule(SBMLModel, parameterRule);
