function functionDefinition = Model_getFunctionDefinition(SBMLModel, number)
%
%   Model_getFunctionDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth function definition structure defined within the model
%
%       functionDefinition = Model_getFunctionDefinition(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getFunctionDefinition(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getFunctionDefinition(SBMLModel, number)', 'no function definitions in a level 1 model'));   
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getFunctionDefinition(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.functionDefinition))
    functionDefinition = [];
else
    functionDefinition = SBMLModel.functionDefinition(number);
end;