function functionDefinitions = Model_getListOfFunctionDefinitions(SBMLModel)
%
%   Model_getListOfFunctionDefinitions 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML function definition structures defined within the model
%
%       functionDefinitions = Model_getListOfFunctionDefinitions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfFunctionDefinitions(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getListOfFunctionDefinitions(SBMLModel)', 'no function definitions in a level 1 model'));    
end;

functionDefinitions = SBMLModel.functionDefinition;