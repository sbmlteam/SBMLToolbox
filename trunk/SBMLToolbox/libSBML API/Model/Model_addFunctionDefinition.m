function SBMLModel = Model_addFunctionDefinition(SBMLModel, SBMLFunctionDefinition)
%
%   Model_addFunctionDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLFunctionDefinition structure
%
%             and returns 
%               the model with the functionDefinition added
%
%       SBMLModel = Model_addFunctionDefinition(SBMLModel, SBMLFunctionDefinition)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addFunctionDefinition(SBMLModel, SBMLFunctionDefinition)', 'first argument must be an SBML model structure'));
elseif (~isSBML_FunctionDefinition(SBMLFunctionDefinition, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addFunctionDefinition(SBMLModel, SBMLFunctionDefinition)', 'second argument must be an SBML functionDefinition structure', sbmlLevel));
end;

numberFunctionDefinitions = length(SBMLModel.functionDefinition);

SBMLModel.functionDefinition(numberFunctionDefinitions+1) = SBMLFunctionDefinition;

