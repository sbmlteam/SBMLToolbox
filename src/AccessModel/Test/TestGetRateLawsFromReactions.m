function fail = TestGetRateLawsFromReactions
% GetRateLawsFromReactions takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species

m = TranslateSBML('test3.xml');

species = {'S1', 'S2', 'S3', 'X'};
rateLaws = {' - (k*S1)', ' + (k*S1) - (k_R2*S2)', ' + (k_R2*S2)', '0'};

fail = TestFunction('GetRateLawsFromReactions', 1, 2, m, species, rateLaws);