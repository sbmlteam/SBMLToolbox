function fail = TestPairBrackets
%
%   PairBrackets 
%             takes a string
%
%             and returns 
%               an array of indices of each pair of brackets
%               ordered from the opening bracket index
%
%----------------------------------------------------------------
% EXAMPLE:
%       pairs = PairBrackets('(a+((b*c)/(a+b)))')
%
%       pairs = 
%                   1   17
%                   4   16
%                   5    9
%                   11  15
%

input = '(a+((b*c)/(a+b)))';
output = [1, 17; 4, 16; 5, 9; 11, 15];

fail = TestFunction('PairBrackets', 1, 1, input, output);