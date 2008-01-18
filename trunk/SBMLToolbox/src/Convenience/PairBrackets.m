function pairs = PairBrackets(formula)
% PairBrackets takes a string 
%       and returns 
%           an array of indices of each pair of brackets
%               ordered from the opening bracket index
%
%----------------------------------------------------------------
% EXAMPLE:
%       pairs = PairBrackets('(a+((b*c)/(a+b)))')
%
%       pairs = 
%                   1   17
%                   4   16
%                   5    9
%                   11  15
%


%  Filename    :   PairBrackets.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   11-Feb-2005
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




if (~ischar(formula))
    error(sprintf('%s\n%s', 'PairBrackets(formula)', 'first argument must be a string'));
end;

OpeningBracketIndex = strfind(formula, '(');
ClosingBracketIndex = strfind(formula, ')');

% check that the number of brackets matches 
if (length(OpeningBracketIndex) ~= length(ClosingBracketIndex))
    error('Bracket mismatch');
end;

if (isempty(OpeningBracketIndex))
    pairs = 0;
    return;
end;

for i = 1:length(OpeningBracketIndex)
    j = length(OpeningBracketIndex);
    while(j > 0)
        if (OpeningBracketIndex(j) < ClosingBracketIndex(i))
            pairs(i,1) = OpeningBracketIndex(j);
            pairs(i,2) = ClosingBracketIndex(i);
            OpeningBracketIndex(j) = max(ClosingBracketIndex);
            j = 0;
        else
            j = j - 1;
        end;
    end;
end;

% order the pairs so that the opening bracket index is in ascending order

OriginalPairs = pairs;

% function 'sort' changes in version 7.0.1

v = version;
v_num = str2num(v(1));

if (v_num < 7)
    TempPairs = sort(pairs, 1);
else
    TempPairs = sort(pairs, 1, 'ascend');
end;

for i = 1:length(OpeningBracketIndex)
    pairs(i, 1) = TempPairs(i, 1);
    j = find(OriginalPairs == pairs(i, 1));
    pairs(i, 2) = OriginalPairs(j, 2);
end;
