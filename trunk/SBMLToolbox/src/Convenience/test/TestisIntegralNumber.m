function fail = TestisIntegralNumber
%
%   isIntegralNumber 
%             takes a number n
%             and returns 1 if it is an integer 0 otherwise
%
%       NOTE: MATLAB's isinteger is only true if the number has been
%       declared as an int; whereas the default type for numbers in MATLAB
%       is double
%
%       value = isIntegralNumber(number)

a = 2;
b = 3.5;

fail = TestFunction('isIntegralNumber', 1, 1, a, 1);
fail = fail + TestFunction('isIntegralNumber', 1, 1, b, 0);