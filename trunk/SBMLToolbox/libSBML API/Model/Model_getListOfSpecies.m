function species = Model_getListOfSpecies(SBMLModel)
%
%   Model_getListOfSpecies 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML species structures defined within the model
%
%       species = Model_getListOfSpecies(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfSpecies(SBMLModel)', 'argument must be an SBML model structure'));
end;

species = SBMLModel.species;