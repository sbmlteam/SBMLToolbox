function fail = TestGetAllParameterSymbolsUnique

m = TranslateSBML('test1.xml');

syms k_1_R1 k_2_R2;

x = [k_1_R1, k_2_R2];

y = [1, 0];

z = {'k_1_R1', 'k_2_R2'};

fail = TestFunction('GetAllParameterSymbolsUnique', 1, 3, m, x, y, z);