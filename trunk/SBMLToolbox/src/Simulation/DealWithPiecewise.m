function Elements = DealWithPiecewise(OriginalFormula)
% DealWithPiecewise takes a string representation of a formula 
%                   that contains the MathML piecewise function 
% and returns 
%           an array of the three components of the piecewise function
%               which can then be written as an if else statement
%     
%   EXAMPLE:
%           elements = DealWithPiecewise('piecewise(le(s2,4),1.5,0.05)')
%
%                    =  'le(s2,4)'  '1.5'   '0.05'


%  Filename    :   DealWithPiecewise.m
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






OriginalFormula = LoseWhiteSpace(OriginalFormula);

OpeningBracketIndex = find((ismember(OriginalFormula, '(')) == 1);

ClosingBracketIndex = find((ismember(OriginalFormula, ')')) == 1);

CommaIndex = find((ismember(OriginalFormula, ',')) == 1);

%pair the brackets
Pairs = PairBrackets(OriginalFormula);

Start = findstr(OriginalFormula, 'piecewise');

if (length(Start) == 0)
    error('DealWithPiecewise(formula)\n%s', 'piecewise either does not occur in the formula');
end;



% find the commas that are between the arguments of the piecwise expression
% not those that may be part of the argument
% e.g.  'piecewise(gt(d,e),lt(2,e),gt(f,d))'
%                         |       |       
%                      relevant commas

piecewiseBrackets = 1;
while(piecewiseBrackets <= length(OpeningBracketIndex))
    if (Pairs(piecewiseBrackets, 1) > Start(1))
        break;
    else
        piecewiseBrackets = piecewiseBrackets + 1;
    end;
end;

for i = 1:length(CommaIndex)
    % if comma is outside the piecwise brackets not relevant
    if (CommaIndex(i) < Pairs(piecewiseBrackets, 1))
        CommaIndex(i) = 0;
    elseif(CommaIndex(i) > Pairs(piecewiseBrackets, 2))
        CommaIndex(i) = 0;
    end;
    
    for j = piecewiseBrackets+1:length(OpeningBracketIndex)
        if ((CommaIndex(i) > Pairs(j, 1)) && (CommaIndex(i) < Pairs(j, 2)))
            CommaIndex(i) = 0;
        end;
    end;
end;

NonZeros = find(CommaIndex ~= 0);

% if there is only one relevant comma
% implies only two arguments
% MATLAB can deal with the OriginalFormula

if (length(NonZeros) ~= 2)
    error('Not enough arguments passed')
end;

% get elements that represent the arguments of the piecewise expression
% as an array of character arrays
% e.g. first element is between opening bracket and first relevant comma
%      next elements are between relevant commas
%      last element is between last relevant comma and closing bracket

j = Pairs(piecewiseBrackets, 1);
ElementNumber = 1;

for i = 1:length(NonZeros)
    element = '';
    j = j+1;
    while (j <= CommaIndex(NonZeros(i)) - 1)
        element = strcat(element, OriginalFormula(j));
        j = j + 1;
    end;
%     if (findstr(element, 'piecewise'))
%         element = DealWithPiecewise(element);
%     end;

    Elements{ElementNumber} = element;
    ElementNumber = ElementNumber + 1;

end;


element = '';
j = j+1;
while (j < Pairs(piecewiseBrackets, 2))
    element = strcat(element, OriginalFormula(j));
    j = j + 1;
end;

% if (findstr(element, 'piecewise'))
%     element = DealWithPiecewise(element);
% end;
Elements{ElementNumber} = element;


% check for a sign in front of leading brackets
if (Pairs (1,1) ~= 1)
    if strcmp(OriginalFormula(1), '-')
        Elements{1} = strcat('-',Elements{1});
        Elements{3} = strcat('-',Elements{3});
    end;
end;
       
    


