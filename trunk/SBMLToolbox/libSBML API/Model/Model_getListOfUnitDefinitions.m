function unitDefinitions = Model_getListOfUnitDefinitions(SBMLModel)
%
%   Model_getListOfUnitDefinitions 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML unit definition structures defined within the model
%
%       unitDefinitions = Model_getListOfUnitDefinitions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfUnitDefinitions(SBMLModel)', 'argument must be an SBML model structure'));
end;

unitDefinitions = SBMLModel.unitDefinition;