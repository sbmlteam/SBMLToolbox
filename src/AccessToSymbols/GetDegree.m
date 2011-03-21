function y = GetDegree(symPoly, var)
% GetDegree(symPoly, var) takes a symbolic polynomial and a single symbol
% and returns 
%           the degree of the symbol var in the symbolic polynomial symPoly
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
%<!---------------------------------------------------------------------------
e% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

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
