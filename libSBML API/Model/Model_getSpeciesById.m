function species = Model_getSpeciesById(SBMLModel, id)
%
%   Model_getSpeciesById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the species to be found
%
%             and returns 
%               the species structure with the matching id 
%               or an empty structure if no such species exists
%               
%       species = Model_getSpeciesById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getSpeciesById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getSpeciesById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getSpeciesById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

species = [];

for i = 1:length(SBMLModel.species)
    if (strcmp(id, SBMLModel.species(i).id))
        species = SBMLModel.species(i);
        return;
    end;
end;