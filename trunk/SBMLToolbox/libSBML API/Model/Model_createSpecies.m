function [species, SBMLModel] = Model_createSpecies(SBMLModel)
%
%   Model_createSpecies 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the species structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created species
%
%       [species, SBMLModel] = Model_createSpecies(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createSpecies(SBMLModel)', 'first argument must be an SBML model structure'));
end;

species = Species_create(SBMLModel.SBML_level);

SBMLModel = Model_addSpecies(SBMLModel, species);
