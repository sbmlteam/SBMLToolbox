function [reactant, SBMLModel] = Model_createReactant(SBMLModel)
%
%   Model_createReactant 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the reactant structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created reactant
%
%       NOTE: the reactant is added to the last reaction created
%
%       [reactant, SBMLModel] = Model_createReactant(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createReactant(SBMLModel)', 'first argument must be an SBML model structure'));
end;

reactant = SpeciesReference_create(SBMLModel.SBML_level);

if (length(SBMLModel.reaction) == 0)
    reactant = [];
    warning('Failed to create reactant');
else
    SBMLModel.reaction(end) = Reaction_addReactant(SBMLModel.reaction(end), reactant);
end;

