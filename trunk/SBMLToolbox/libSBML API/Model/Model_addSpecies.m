function SBMLModel = Model_addSpecies(SBMLModel, SBMLSpecies)
%
%   Model_addSpecies 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLSpecies structure
%
%             and returns 
%               the model with the species added
%
%       SBMLModel = Model_addSpecies(SBMLModel, SBMLSpecies)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addSpecies(SBMLModel, SBMLSpecies)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addSpecies(SBMLModel, SBMLSpecies)', 'second argument must be an SBML species structure', sbmlLevel));
end;

numberSpeciess = length(SBMLModel.species);

SBMLModel.species(numberSpeciess+1) = SBMLSpecies;

