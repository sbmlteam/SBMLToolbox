function [speciesConcentrationRule, SBMLModel] = Model_createSpeciesConcentrationRule(SBMLModel)
%
%   Model_createSpeciesConcentrationRule 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the speciesConcentrationRule structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created speciesConcentrationRule
%
%       [speciesConcentrationRule, SBMLModel] = Model_createSpeciesConcentrationRule(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createSpeciesConcentrationRule(SBMLModel)', 'first argument must be an SBML model structure'));
end;

speciesConcentrationRule = SpeciesConcentrationRule_create(SBMLModel.SBML_level);

SBMLModel = Model_addRule(SBMLModel, speciesConcentrationRule);
