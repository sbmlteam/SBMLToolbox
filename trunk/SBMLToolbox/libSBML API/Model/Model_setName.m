function SBMLModel = Model_setName(SBMLModel, name)
%
%   Model_setName 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the model with the name set
%
%       SBMLModel = Model_setName(SBMLModel, 'name')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_setName(SBMLModel, name)', 'first argument must be an SBML model structure'));
elseif (~ischar(name))
    error(sprintf('Model_setName(SBMLModel, name)\n%s', 'second argument must be a string representing the name of the model'));
end;

SBMLModel.name = name;