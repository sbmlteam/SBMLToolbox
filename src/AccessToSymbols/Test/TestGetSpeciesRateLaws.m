function fail = TestGetSpeciesRateLaws(SBMLModel)
% GetSpeciesRateLaws(SBMLModel) takes an SBML model 
% returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%--------------------------------------------------------------------------

m = TranslateSBML('test3.xml');

syms S1 S2 S3 X k k_R2 k_R2;

species = [S1, S2, S3, X];
rateLaws = [-k_R2*S1, k_R2*S1-k_R2*S2, k_R2*S2, X];

fail = TestFunction('GetSpeciesRateLaws', 1, 2, m, species, rateLaws);