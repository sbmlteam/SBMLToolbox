function fail = TestcharFormula2sym
% charFormula2sym converts a character representation of a mathematical formula
% to a symbolic representation of that formula
%
% returns 
%     1) the symbolic representation of the formula as first output argument
%     2) an array of the symbols used within the formula as second output
%     argument
%
%-------------------------------------------------------------------------
% EXAMPLE:  [y, z] = charFormula2sym('2 * (a^2) + (3 * b) + c')
%           y = 2*a^2+3*b+c
%           z = [a, b, c]

formula = '2 * (a^2) + (3 * b) + c';

syms a b c;

y = 2*a^2+3*b+c;
z = [a, b, c];

fail = TestFunction('charFormula2sym', 1,2, formula, y, z);