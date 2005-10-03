function fail = TestGetRateLawsFromRules
% GetRateLawsFromRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species from rules

m = TranslateSBML('test4.xml');

species = {'s1', 's2'};
rules = {'5', '0'};

fail = TestFunction('GetRateLawsFromRules', 1, 2, m, species, rules);