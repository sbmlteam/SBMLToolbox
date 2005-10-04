function fail = TestGetArgumentsFromLambdaFunction
%
%   GetArgumentsFromLambdaFunction 
%             takes a string representation of a formula that contains the MathML lambda function 
%
%             and returns 
%               an array of the components of the lambda function
%               which can then be used to substitute 
%     
%   EXAMPLE:
%           elements = GetArgumentsFromLambdaFunction('lambda(x, x+0.5)')
%
%                    =  'x'  'x+0.5'   
%
%           elements = GetArgumentsFromLambdaFunction('lambda(x, y, x + y)')
%
%                    =  'x'  'y'    'x+y'   

input1 = 'lambda(x, x+0.5)';
output1 = {'x', 'x+0.5'};

input2 = 'lambda(x, y, x + y)';
output2 = {'x', 'y', 'x+y'};


fail = TestFunction('GetArgumentsFromLambdaFunction', 1, 1, input1, output1);
fail = fail + TestFunction('GetArgumentsFromLambdaFunction', 1, 1, input2, output2);
