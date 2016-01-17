function fail = TestRearrange
% Rearrange(formula, x)
%         takes a char array representing a formula
%         and   a char array representing a variable
%
% and returns the formula rearranged in terms of x
%
%--------------------------------------------------------------------------
% EXAMPLE:    output   =   Rearrange('X + Y - Z', 'X')
%                      =   '-Y+Z'
%--------------------------------------------------------------------------

%  Filename    :   TestRearrange.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
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


formula = 'a+b';
var = 'c';
output = 'a+b';

fail = TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'a+b';
var = 'b';
output = '-a';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'a+b-c';
var = 'b';
output = '-a+c';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'b/a';
var = 'b';
output = '0';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = '3b/a';
var = 'b';
output = '0';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'a/b';
var = 'b';
output = '';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'b + c/a';
var = 'b';
output = '-c/a';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + a/b';
var = 'b';
output = '(a/1)*(1/(-c))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + a/b';
var = 'a';
output = '-c*(b/1)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + 3*a/b';
var = 'a';
output = '-c*(b/3)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + a/4*b';
var = 'a';
output = '-c*(4/(1*b))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + 2*a/5*b';
var = 'a';
output = '-c*(5/(2*b))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + 3*a/b';
var = 'b';
output = '((3*a)/1)*(1/(-c))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + a/4*b';
var = 'b';
output = '-c*(4/a)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c + 2*a/5*b';
var = 'b';
output = '-c*(5/(2*a))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'a+b-c+2*c';
var = 'c';
output = '(-a-b)/(-1+2)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'a+ 2/c +d';
var = 'c';
output = '(1/0.5)*(1/(-a-d))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = '(a+b) -c';
var = 'c';
output = '-(-(a+b))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c/(a+b) + d';
var = 'c';
output = '-d*((a+b)/1)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = '(a+b)/c + d';
var = 'c';
output = '((a+b)/1)*(1/(-d))';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c/a + c/d -e';
var = 'c';
output = '(+e)/(1/a+1/d)';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);

formula = 'c/a + c/d';
var = 'c';
output = '0';

fail = fail + TestFunction('Rearrange', 2, 1, formula, var, output);
