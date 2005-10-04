function fail = TestDealWithPiecewise
%
%   DealWithPiecewise 
%             takes a string representation of a formula that contains the MathML piecewise function 
%
%             and returns 
%               an array of the three components of the piecewise function
%               which can then be written as an if else statement
%     
%   EXAMPLE:
%           elements = DealWithPiecewise('piecewise(le(s2,4),1.5,0.05)')
%
%                    =  'le(s2,4)'  '1.5'   '0.05'

input = 'piecewise(le(s2,4),1.5,0.05)';
output = {'le(s2,4)', '1.5', '0.05'};

fail = TestFunction('DealWithPiecewise', 1, 1, input, output);