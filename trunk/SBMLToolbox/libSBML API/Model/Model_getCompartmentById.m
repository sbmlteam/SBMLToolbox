function compartment = Model_getCompartmentById(SBMLModel, id)
%
%   Model_getCompartmentById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the compartment to be found
%
%             and returns 
%               the compartment structure with the matching id 
%               or an empty structure if no such compartment exists
%               
%       compartment = Model_getCompartmentById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getCompartmentById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getCompartmentById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getCompartmentById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

compartment = [];

for i = 1:length(SBMLModel.compartment)
    if (strcmp(id, SBMLModel.compartment(i).id))
        compartment = SBMLModel.compartment(i);
        return;
    end;
end;