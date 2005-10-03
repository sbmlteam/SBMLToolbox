function fail = TestGetParameterSymbolsFromReaction
% GetParameterSymbolsFromReaction takes a SBMLReaction 
% and returns 
%           1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%

m = TranslateSBML('test3.xml');
r = m.reaction(2);

syms k;
symbols = [k];
names = {'k'};
values = 0.1;

fail = TestFunction('GetParameterSymbolsFromReaction', 1, 3, r, symbols, values, names);