function [reaction, SBMLModel] = Model_createReaction(SBMLModel)
%
%   Model_createReaction 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the reaction structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created reaction
%
%       [reaction, SBMLModel] = Model_createReaction(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createReaction(SBMLModel)', 'first argument must be an SBML model structure'));
end;

reaction = Reaction_create(SBMLModel.SBML_level);

SBMLModel = Model_addReaction(SBMLModel, reaction);
