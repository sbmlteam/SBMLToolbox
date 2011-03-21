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
