function y = TestFunction(varargin)
% TestFunction takes 
%           1) the name of a function
%           2) the number of input arguments to the function
%           3) the number of output arguments to the function
%           4) the input arguments
%           5) the expected output arguments
%
%       and returns 
%           1 if if the expected output does not equal to actual output 
%           0 otherwise
%
% EXAMPLE:
%         y = TestFunction('CheckValidUnitKind', 1, 1, 'metre', 1)
%         
%         returns y = 0 (expected output = actual output)
%         since CheckUnitKind('metre') returns 1
%
%         y = TestFunction('CheckValidUnitKind', 1, 1, 'met', 1)
%         
%         returns y = 1 (expected output ~= actual output)
%         since CheckUnitKind('met') returns 0
% 

%  Filename    :   TestFunction.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
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


y = 0;
if (nargin < 3)
    error('Need at least 3 inputs');
end;

func = varargin{1};
fhandle = str2func(func);

number_in = varargin{2};
number_out = varargin{3};

if (nargin < 3+number_in+number_out)
    error('incorrect number of arguments');
end;

start_out = 4 + number_in;

fail = 0;
switch number_out
    case 0
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~testEquality(a);
    case 1
        switch number_in
            case 1
                [a] = feval(fhandle, varargin{4});
            case 2
                [a] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~testEquality(a, varargin{start_out});
    case 2
        switch number_in
            case 1
                [a, b] = feval(fhandle, varargin{4});
            case 2
                [a, b] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~testEquality(a, varargin{start_out});
        fail = fail + ~testEquality(b, varargin{start_out+1});
    case 3
        switch number_in
            case 1
                [a, b, c] = feval(fhandle, varargin{4});
            case 2
                [a, b, c] = feval(fhandle, varargin{4}, varargin{5});
            case 3
                [a] = feval(fhandle, varargin{4}, varargin{5}, varargin{6});
        end;
        fail = fail + ~testEquality(a, varargin{start_out});
        fail = fail + ~testEquality(b, varargin{start_out+1});
        fail = fail + ~testEquality(c, varargin{start_out+2});
    otherwise
        error('too many output');
end;
 
if (fail > 0)
    y = 1;
end;

function y = testEquality(array1, array2)

y = isequal(array1, array2);

if y == 1
  return;
elseif length(array1) ~= length(array2)
  y = 0;
  return;
elseif issparse(array1)
  array1_full = full(array1);
  array2_full = full(array2);
  y = testEquality(array1_full, array2_full);
else
  y = 1;
  i = 1;
  % check whether we are dealing with a nan which will always fail equality
  while (y == 1 && i <= length(array1))
    if isnan(array1(i))
      y = isnan(array2(i));
    else
      y = isequal(array1(i), array2(i));
    end;
    i = i + 1;
  end;
end;


