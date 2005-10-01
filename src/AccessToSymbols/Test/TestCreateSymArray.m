function fail = TestCreateSymArray
% CreateSymArray(Input) takes any symbolic expression or set of symbolic expressions
% and returns an array of the single symbolic expressions found in the input 
%
%----------------------------------------------------------------
% EXAMPLE: CreateSymArray(a1^2*bd*c^3)
%           =   [a1, bd, c]
%----------------------------------------------------------------

syms a1 bd c;

formula = a1^2*bd*c^3;

y = [a1, bd, c];

fail = TestFunction('CreateSymArray', 1, 1, formula, y);