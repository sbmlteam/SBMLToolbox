function [rateRule, SBMLModel] = Model_createRateRule(SBMLModel)
%
%   Model_createRateRule 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the rateRule structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created rateRule
%
%       [rateRule, SBMLModel] = Model_createRateRule(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createRateRule(SBMLModel)', 'first argument must be an SBML model structure'));
end;

rateRule = RateRule_create(SBMLModel.SBML_level);

SBMLModel = Model_addRule(SBMLModel, rateRule);
