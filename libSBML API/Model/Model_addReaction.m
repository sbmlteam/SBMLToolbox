function SBMLModel = Model_addReaction(SBMLModel, SBMLReaction)
%
%   Model_addReaction 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLReaction structure
%
%             and returns 
%               the model with the reaction added
%
%       SBMLModel = Model_addReaction(SBMLModel, SBMLReaction)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addReaction(SBMLModel, SBMLReaction)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addReaction(SBMLModel, SBMLReaction)', 'second argument must be an SBML reaction structure', sbmlLevel));
end;

numberReactions = length(SBMLModel.reaction);

SBMLModel.reaction(numberReactions+1) = SBMLReaction;

