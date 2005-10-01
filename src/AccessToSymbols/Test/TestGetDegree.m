function fail = TestGetDegree
% GetDegree(symPoly, var) takes a symbolic polynomial and a single symbol
% and returns the degree of the symbol var in the symbolic polynomial symPoly
%
% -----------------------------------------------
% EXAMPLE: 
%   GetDegree(a1^2*bd*c^3, a1)  =   2
% 
%   GetDegree(a1^2*bd*c^3, c)   =   3
% 
%   GetDegree(a1^2*bd*c^3, bd)  =   1
%
%   GetDegree(a1^2*bd*c^3, x)   =   0
% -----------------------------------------------
fail = 0;
syms a1 c bd x;

formula = a1^2*bd*c^3;

fail = fail + TestFunction('GetDegree', 2, 1, formula, a1, 2);
fail = fail + TestFunction('GetDegree', 2, 1, formula, c, 3);
fail = fail + TestFunction('GetDegree', 2, 1, formula, bd, 1);
fail = fail + TestFunction('GetDegree', 2, 1, formula, x, 0);
fail = fail + TestFunction('GetDegree', 2, 1, a1^2, a1, 2);
