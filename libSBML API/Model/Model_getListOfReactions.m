function reactions = Model_getListOfReactions(SBMLModel)
%
%   Model_getListOfReactions 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML reaction structures defined within the model
%
%       reactions = Model_getListOfReactions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfReactions(SBMLModel)', 'argument must be an SBML model structure'));
end;

reactions = SBMLModel.reaction;