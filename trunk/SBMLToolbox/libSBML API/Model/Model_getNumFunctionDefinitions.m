function number = Model_getNumFunctionDefinitions(SBMLModel)
%
%   Model_getNumFunctionDefinitions
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of function definition structures defined within the model
%
%       number = Model_getNumFunctionDefinitions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumFunctionDefinitions(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getNumFunctionDefinitions(SBMLModel)', 'no function definitions in a level 1 model'));   
end;

number = 0;

if (~isempty(SBMLModel.functionDefinition))
    number = length(SBMLModel.functionDefinition);
end;