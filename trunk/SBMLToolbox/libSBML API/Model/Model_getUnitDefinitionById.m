function unitDefinition = Model_getUnitDefinitionById(SBMLModel, id)
%
%   Model_getUnitDefinitionById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the unit definition to be found
%
%             and returns 
%               the unit definition structure with the matching id 
%               or an empty structure if no such unit definition exists
%               
%       unitDefinition = Model_getUnitDefinitionById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

unitDefinition = [];

for i = 1:length(SBMLModel.unitDefinition)
    if (strcmp(id, SBMLModel.unitDefinition(i).id))
        unitDefinition = SBMLModel.unitDefinition(i);
        return;
    end;
end;