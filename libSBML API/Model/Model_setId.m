function SBMLModel = Model_setId(SBMLModel, id)
%
%   Model_setId 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the model with the id set
%
%       SBMLModel = Model_setId(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_setId(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('Model_setId(SBMLModel, id)\n%s', 'second argument must be a string representing the id of the model'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_setId(SBMLModel, id)', 'no id field in a level 1 model'));    
end;

SBMLModel.id = id;