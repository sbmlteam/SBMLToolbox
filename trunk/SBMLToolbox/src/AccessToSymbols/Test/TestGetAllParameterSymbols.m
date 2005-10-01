function fail = TestGetAllParameterSymbols
% GetAllParameterSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value -1 is used
%--------------------------------------------------------------------------

m = TranslateSBML('test1.xml');

syms k_1 k_2;

x = [k_1, k_2];

y = [1, 0];

z = {'k_1', 'k_2'};

fail = TestFunction('GetAllParameterSymbols',1, 3, m, x, y, z);