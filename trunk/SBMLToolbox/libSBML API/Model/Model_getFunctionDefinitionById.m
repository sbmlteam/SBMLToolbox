function functionDefinition = Model_getFunctionDefinitionById(SBMLModel, id)
%
%   Model_getFunctionDefinitionById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the function definition to be found
%
%             and returns 
%               the function definition structure with the matching id 
%               or an empty structure if no such function definition exists
%               
%       functionDefinition = Model_getFunctionDefinitionById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getFunctionDefinitionById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getFunctionDefinitionById(SBMLModel, id)', 'no function definitions in a level 1 model'));   
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getFunctionDefinitionById(SBMLModel, id)', 'second argument must be a string'));
end;

functionDefinition = [];

for i = 1:length(SBMLModel.functionDefinition)
    if (strcmp(id, SBMLModel.functionDefinition(i).id))
        functionDefinition = SBMLModel.functionDefinition(i);
        return;
    end;
end;