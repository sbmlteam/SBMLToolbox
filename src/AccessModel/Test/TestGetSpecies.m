function fail = TestGetSpecies
% GetSpecies takes a SBMLModel 
% and returns 
%           1) an array of character names of all species within the model 
%           2) an array of the initial concentration values of each species
%

m = TranslateSBML('test1.xml');

names = {'S1', 'S2'};
values = [1.5e-15, 1.45];

fail = TestFunction('GetSpecies', 1, 2, m, names, values);