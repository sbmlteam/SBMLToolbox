function pairs = PairBrackets(formula)
%
%   PairBrackets 
%             takes a string
%
%             and returns 
%               an array of indices of each pair of brackets
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

TempPairs = sort(pairs, 1, 'ascend');

for i = 1:length(OpeningBracketIndex)
    pairs(i, 1) = TempPairs(i, 1);
    j = find(OriginalPairs == pairs(i, 1));
    pairs(i, 2) = OriginalPairs(j, 2);
end;
