function [modifier, SBMLModel] = Model_createModifier(SBMLModel)
%
%   Model_createModifier 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the modifier structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created modifier
%
%       NOTE: the modifier is added to the last reaction created
%
%       [modifier, SBMLModel] = Model_createModifier(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createModifier(SBMLModel)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_createModifier(SBMLModel)', 'no modifiers in a level 1 model'));
end;

modifier = ModifierSpeciesReference_create;

if (length(SBMLModel.reaction) == 0)
    modifier = [];
    warning('Failed to create modifier');
else
    SBMLModel.reaction(end) = Reaction_addModifier(SBMLModel.reaction(end), modifier);
end;

