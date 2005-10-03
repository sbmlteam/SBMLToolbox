function fail = TestGetSpeciesSymbols
% GetSpeciesSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all species within the model 
%           2) an array of the initial concentration values of each species
%           3) an array of character names of the symbols

m = TranslateSBML('test1.xml');

syms S1 S2;

symbols = [S1, S2];
names = {'S1', 'S2'};
values = [1.5e-15, 1.45];

fail = TestFunction('GetSpeciesSymbols', 1, 3, m, symbols, values, names);