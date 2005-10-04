function fail = TestLoseWhiteSpace
% LoseWhiteSpace(charArray) takes an array of characters
% and returns the array with any white space removed
%
%----------------------------------------------------------------
% EXAMPLE:
%           y = LoseWhiteSpace('     exa  mp le')
%           y = 'example'
%

input = '    exa mp le  ';
output = 'example';

fail = TestFunction('LoseWhiteSpace', 1, 1, input, output);