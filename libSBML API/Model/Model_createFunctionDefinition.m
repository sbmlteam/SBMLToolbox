function [functionDefinition, SBMLModel] = Model_createFunctionDefinition(SBMLModel)
%
%   Model_createFunctionDefinition 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the functionDefinition structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created functionDefinition
%
%       [functionDefinition, SBMLModel] = Model_createFunctionDefinition(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createFunctionDefinition(SBMLModel)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_createFunctionDefinition(SBMLModel)', 'no function definitions in a level 1 model'));   
end;

functionDefinition = FunctionDefinition_create;

SBMLModel = Model_addFunctionDefinition(SBMLModel, functionDefinition);
