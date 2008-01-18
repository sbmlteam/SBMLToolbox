function y = RemoveDuplicates(FullArray)
% RemoveDuplicates takes any array 
%       and returns 
%           the array with any duplicates removed

%
%  Filename    : RemoveDuplicates.m
%  Description : takes any array and returns it with any duplicates removed
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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

% check whether array is a column vector
[size_x, size_y] = size(FullArray);
if (size_y == 1 && size_x ~= 1)
    y = RemoveDuplicatesColumn(FullArray);
    return;
end;
%-------------------------------------------------------------
% find number of elements in existing array
NoElements = length(FullArray);

if (NoElements == 0)
    y = [];
    return;
end;

% copy first element of the array to the new array
newArrayIndex = 1;
NewArray(1) = FullArray(1);

%loop through all elements
% if they do not already exist in new array copy them into it
for i = 2:NoElements
    element = FullArray(i);
    if (~ismember(element, NewArray))
        newArrayIndex = newArrayIndex + 1;
        NewArray(newArrayIndex) = element;
    end;
end;

y = NewArray;
   

function y = RemoveDuplicatesColumn(FullArray)
% RemoveDuplicatesCell takes column vector
% and returns it with any duplicates removed

% find number of elements in existing array
[NoElements, x] = size(FullArray);

% copy first element of the array to the new array
newArrayIndex = 1;
NewArray(1,x) = FullArray(1);

%loop through all elements
% if they already exist in new array do not copy
for i = 2:NoElements
    element = FullArray(i);
    if (~ismember(element, NewArray))
        newArrayIndex = newArrayIndex + 1;
        NewArray(newArrayIndex,x) = element;
    end;
end;

y = NewArray;
