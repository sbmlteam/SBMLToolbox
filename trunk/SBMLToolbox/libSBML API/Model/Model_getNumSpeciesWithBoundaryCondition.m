function number = Model_getNumSpeciesWithBoundaryCondition(SBMLModel)
%
%   Model_getNumSpeciesWithBoundaryCondition 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of species structures 
%               with a boundary condition set to true
%
%       number = Model_getNumSpeciesWithBoundaryCondition(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumSpeciesWithBoundaryCondition(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

for i = 1:length(SBMLModel.species)
    if (SBMLModel.species(i).boundaryCondition == 1)
        number = number + 1;
    end;
end;