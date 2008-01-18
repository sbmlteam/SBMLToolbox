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

%  Filename    :   TestGetArgumentsFromLambdaFunction.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



input1 = 'lambda(x, x+0.5)';
output1 = {'x', 'x+0.5'};

input2 = 'lambda(x, y, x + y)';
output2 = {'x', 'y', 'x+y'};


fail = TestFunction('GetArgumentsFromLambdaFunction', 1, 1, input1, output1);
fail = fail + TestFunction('GetArgumentsFromLambdaFunction', 1, 1, input2, output2);

m = TranslateSBML('../../Test/test-data/l2v1-all.xml');

input = m.functionDefinition.math;
output = {'x', 'power(x,3)'};

fail = fail + TestFunction('GetArgumentsFromLambdaFunction', 1, 1, input, output);

