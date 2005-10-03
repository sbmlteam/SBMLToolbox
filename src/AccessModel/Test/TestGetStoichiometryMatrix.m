function fail = TestGetStoichiometryMatrix
% GetStoichiometryMatrix(SBMLModel) takes an SBML model 
% returns 
%       1) stoichiometry matrix
%       2) an array of character names of all species within the model 

m = TranslateSBML('test3.xml');

matrix = [1, 0; 1, 1; 0, 1; 0, 0];
species = {'S1', 'S2', 'S3', 'X'};

fail = TestFunction('GetStoichiometryMatrix', 1, 2, m, matrix, species);