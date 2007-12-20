function fail = TestRearrange

%  Filename    :   TestRearrange.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


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
