function species = Model_getSpecies(SBMLModel, number)
%
%   Model_getSpecies 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth species structure defined within the model
%
%       species = Model_getSpecies(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getSpecies(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getSpecies(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.species))
    species = [];
else
    species = SBMLModel.species(number);
end;