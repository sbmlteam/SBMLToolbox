function fail = TestGetSpeciesAlgebraicRules
% GetSpeciesAlgebraicRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of each algebraic
%             rule the species appears in

m = TranslateSBML('test3.xml');

species = {'S1', 'S2', 'S3', 'X'};
rules = {{'X+S1-S3'}, '0', {'X+S1-S3'}, {'X+S1-S3'}};

fail = TestFunction('GetSpeciesAlgebraicRules', 1, 2, m, species, rules);