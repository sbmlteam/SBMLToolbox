function rules = Model_getListOfRules(SBMLModel)
%
%   Model_getListOfRules 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML rule structures defined within the model
%
%       rules = Model_getListOfRules(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfRules(SBMLModel)', 'argument must be an SBML model structure'));
end;

rules = SBMLModel.rule;