function number = Model_getNumSpecies(SBMLModel)
%
%   Model_getNumSpecies 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of species structures defined within the model
%
%       number = Model_getNumSpecies(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumSpecies(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.species))
    number = length(SBMLModel.species);
end;