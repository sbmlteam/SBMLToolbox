function parameter = Model_getParameterById(SBMLModel, id)
%
%   Model_getParameterById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the parameter to be found
%
%             and returns 
%               the parameter structure with the matching id 
%               or an empty structure if no such parameter exists
%               
%       parameter = Model_getParameterById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getParameterById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getParameterById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getParameterById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

parameter = [];

for i = 1:length(SBMLModel.parameter)
    if (strcmp(id, SBMLModel.parameter(i).id))
        parameter = SBMLModel.parameter(i);
        return;
    end;
end;