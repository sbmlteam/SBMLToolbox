function [parameter, SBMLModel] = Model_createParameter(SBMLModel)
%
%   Model_createParameter 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the parameter structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created parameter
%
%       [parameter, SBMLModel] = Model_createParameter(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createParameter(SBMLModel)', 'first argument must be an SBML model structure'));
end;

parameter = Parameter_create(SBMLModel.SBML_level);

SBMLModel = Model_addParameter(SBMLModel, parameter);
