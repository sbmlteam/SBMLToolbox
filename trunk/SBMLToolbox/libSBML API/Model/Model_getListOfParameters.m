function parameters = Model_getListOfParameters(SBMLModel)
%
%   Model_getListOfParameters 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML parameter structures defined within the model
%
%       parameters = Model_getListOfParameters(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfParameters(SBMLModel)', 'argument must be an SBML model structure'));
end;

parameters = SBMLModel.parameter;