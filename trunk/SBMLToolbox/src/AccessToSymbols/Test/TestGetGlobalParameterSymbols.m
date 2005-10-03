function fail = TestGetGlobalParameterSymbols
% GetGlobalParameterSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all global parameters within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%

m = TranslateSBML('test3.xml');

syms k;

symbols = [k];
names = {'k'};
values = 1;

fail = TestFunction('GetGlobalParameterSymbols', 1, 3, m, symbols, values, names);