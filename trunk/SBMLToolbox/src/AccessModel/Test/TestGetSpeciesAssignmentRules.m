function fail = TestGetSpeciesAssignmentRules
% GetSpeciesAssignmentRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the
%             concentration for each species assigned by rules

m = TranslateSBML('test3.xml');

species = {'S1', 'S2', 'S3', 'X'};
rules = {'0', '0', '3+4', '0'};

fail = TestFunction('GetSpeciesAssignmentRules', 1, 2, m, species, rules);