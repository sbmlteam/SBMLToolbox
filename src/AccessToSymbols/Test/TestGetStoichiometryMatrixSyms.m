function fail = TestGetStoichiometryMatrixSyms
% GetStoichiometryMatrixSyms(SBMLModel) takes an SBML model 
% returns 
%       stoichiometry matrix as first output
%       array of symbols respresenting each species in same order
%           as the stoichiometry matrix treats them
%--------------------------------------------------------------------------

m = TranslateSBML('test3.xml');

syms S1 S2 S3 X;
matrix = [1, 0; 1, 1; 0, 1; 0, 0];
species = [S1, S2, S3, X];

fail = TestFunction('GetStoichiometryMatrixSyms', 1, 2, m, matrix, species);