function number = Model_getNumReactions(SBMLModel)
%
%   Model_getNumReactions 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of reaction structures defined within the model
%
%       number = Model_getNumReactions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumReactions(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.reaction))
    number = length(SBMLModel.reaction);
end;