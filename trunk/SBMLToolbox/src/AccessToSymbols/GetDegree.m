function y = GetDegree(symPoly, var)
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

%
%  Filename    : GetDegree.m
%  Description :takes a symbolic polynomial and a single symbol
%               and returns the degree of the symbol in the symbolic polynomial
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
%
%  Copyright 2003 California Institute of Technology, the Japan Science
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
%      Science and Technology Research School
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):

if (nargin ~= 2)
    error('Too few input arguments');
end;

%check thar var is a single symbol
%and that the inputs are symbolic
symArrayVar = CreateSymArray(var);
NoSyms = length(symArrayVar);
if (~(isa(symPoly, 'sym')))
    error('%s\n%s', 'GetDegree(symPoly, var)', 'symPoly must be a symbolic expression');
elseif (~(isa(var, 'sym')) || NoSyms ~=1)
    error('%s\n%s', 'GetDegree(symPoly, var)', 'var must be a single symbol');
end;

% ------------------------------------------------------------------------
% determine all symbols present in the polynomial
cSymbols = CreateSymArray(symPoly);
NoSyms = length(cSymbols);

%loop through each symbol in the polynomial
% and substitute 1 if not the symbol being considered
indexVar = find(cSymbols == var);
if (isempty(indexVar))
    y = 0;
    return;
elseif ((indexVar == 1) && (NoSyms == 1))
%     symPolySub(1) = cSymbols(1);
    symPolySub = symPoly;
else
    for i = 1:indexVar-1
        symPolySub(i) = cSymbols(i);
        Array(i) = 1;
    end;
    for i = indexVar:NoSyms-1
        symPolySub(i) = cSymbols(i+1);
        Array(i) = 1;
    end;
    symPolySub = subs(symPoly, symPolySub, Array);
end;

% check that we still have variables
% if not degree = 0 return
if (isnumeric(symPolySub))
    y = 0;
    return;
end;

%----------------------------------------------------------------
% convert to a polynomial with coefficients for each degree of var
% e.g. sym2poly(x^3 + 2*x + 6) = [1, 0, 2, 6]

vecPoly = sym2poly(symPolySub);

No = length(vecPoly);

% degree of the polynomial is the size of the vector minus 1
y = No - 1;