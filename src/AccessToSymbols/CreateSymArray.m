function y = CreateSymArray(Input)
% CreateSymArray takes any symbolic expression or set of symbolic expressions
% and returns 
%           an array of the single symbolic expressions found in the input 
%
%----------------------------------------------------------------
% EXAMPLE: CreateSymArray(a1^2*bd*c^3)
%           =   [a1, bd, c]
%----------------------------------------------------------------

%
%  Filename    : CreateSymArray.m
%  Description : takes any symbolic expression or set of symbolic expressions
%                  and returns an array of the single symbolic expressions found in the input
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
%

if (isempty(Input))
    y = [];
    return;
end;

% check that input is symbolic
if (~(isa(Input, 'sym')))
    error('%s\n%s', 'CreateSymArray(Input)', 'Input must be symbolic');
end;

%----------------------------------------------------------------

% determine all symbols present in the input
% NOTE: Input = a1^2*bd*c^3
%       symbols = findsym(Input) = 'a1,bd,c'
symbols = findsym(Input);
NoChars = length(symbols);

% add a comma at the end to facilitate the transfer from char to sym
symbols(NoChars+1) = ',';

% catch case of symbolic input representing a number
if (NoChars == 0)
    y = [];
    return;
end;

%----------------------------------------------------------------

% loop through the input and determine the char 
% representation for each symbol

% add each as a symbol to the output array

NoSyms = 0;
cSymbol = '';
i = 1;
Start = 1;
End = 1;
% NOTE: symbols = 'a1,bd,c,'
while (i < NoChars+2)
    
    if (symbols(i) == ',')
        % comma indicates the end of a symbol
        End = i-1;
        cSymbol = symbols(Start:End);
        
        % add to array of symbols
        NoSyms = NoSyms+1;
        cSymbols(NoSyms) = sym(cSymbol);
        cSymbol = '';
        
        i = i+1;
        Start = i;
    else
        i = i+ 1;           
    end;
    
end;

% return the array of symbols
y = RemoveDuplicates(cSymbols);