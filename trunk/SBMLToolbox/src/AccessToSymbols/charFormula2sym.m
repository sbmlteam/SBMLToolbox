function [y,z] = charFormula2sym(charArray)
% charFormula2sym takes a characater representation of a mathematical formula
% and returns 
%           1) the symbolic representation of the formula 
%           2) an array of the symbols used within the formula 
%
%-------------------------------------------------------------------------
% EXAMPLE:  [y, z] = charFormula2sym('2 * (a^2) + (3 * b) + c')
%           y = 2*a^2+3*b+c
%           z = [a, b, c]
%
% EXAMPLE:  [y,z] = charFormula2sym('(a+a+a+b) + (a1*b/c*f) - 3*a')
%           y = b+a1*b/c*f
%           z = [a, b, a1, c, f]
%------------------------------------------------------------
% as yet cannot deal with nested brackets

%
%  Filename    : charFormula2sym.m
%  Description : converts a characater representation of a mathematical formula
%                   to a symbolic representation of that formula
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

% allowed operators
OperatorLookup = '+-*/^';

% table of digits
Digits = '0123456789.-';

%------------------------------------------------------------
% check appropriate input
% i.e.  array of chars
%       No nested brackets

if (isempty(charArray))
    y = sym('');
    z = [];
    return;
elseif (~ischar(charArray))
    error('charFormula2sym(input)\n%s', 'input must be an array of characters');
elseif (CheckNestedBrackets(charArray) == 1)
    error('charFormula2sym(input)\n%s', 'nested brackets found in input - cannot deal yet');
end;

%--------------------------------------------------------------------
%lose white space in the character array
charArray = LoseWhiteSpace(charArray);

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

%--------------------------------------------------------------------
% check to see if there are any brackets
% if not ConvertToSym can deal with whole formula

OpeningBrackets = ismember('(', charArray);
NoOpeningBrackets = sum(OpeningBrackets);
OpeningBracketIndex = find(OpeningBrackets == 1);

ClosingBrackets = ismember(')', charArray);
NoClosingBrackets = sum(ClosingBrackets);
ClosingBracketIndex = find(ClosingBrackets == 1);

if (NoOpeningBrackets == 0 && NoClosingBrackets == 0)
    % no brackets so whole formula is one expression
    [y, z] = ConvertToSym(charArray);
    return;
elseif (NoOpeningBrackets ~= NoClosingBrackets)
    error('charFormula2sym(input)\n%s', 'mismatch in brackets in input');
end;

%-------------------------------------------------------------------------
% remove brackets to create an array of subexpressions with operators
% between them
% loop through the array 
%   (1) to determine subexpressions
%   (2) check whether there is a leading operator i.e. -a*...

NoSubFunctions = 0;
NoOperators = 0;
bLeadingOperator = 0;
LastOperator = 0;
insideFlag = 0;
output = '';
for i = 1:NoChars
    c = charArray(i);
    
    
    if (c == '(')
        %opening bracket
        % clear output and set insideFlag
        output = '';
        insideFlag = 1;
        
    elseif(c == ')')
        %closing bracket
        
        % save output as a sub function
        NoSubFunctions = NoSubFunctions + 1;
        ArrayFunctions{NoSubFunctions} = output;
        
        % clear output and insideFlag
        output = '';
        insideFlag = 0;
        
    elseif (insideFlag == 0)
        % not a bracket but term is outside any brackets
        
        % check for type of term
        if (ismember(c, OperatorLookup))
            %operators between brackets
            
            % determine whether a leading operator i.e. -a
            if (i == 1)
                %no symbols have been found; leading operator
                bLeadingOperator = 1;
                
            elseif (~isempty(output))
                % if there is a function in the output
                % write to the array of functions
                % clear the output
                NoSubFunctions = NoSubFunctions + 1;
                ArrayFunctions{NoSubFunctions} = output;
                output = '';
            end; 
            
            % deal with case of a negative number
            % i.e. a '-' sign that is not a leading operator
            % which occurs immediately after another operator e.g. a*-3
            if (isequal(c, '-') && i ~= 1 && LastOperator == i-1)
                
                % add the - sign to the output as part of a symbol
                if (~isempty(output))
                    error ('Unexpected minus sign found');
                else
                    output = c;
                end;
                
            else
                % add the operator to the array of operators
                NoOperators = NoOperators+1;
                OperatorArray(NoOperators) = c;
                
                % keep track of operator index to catch negative numbers
                LastOperator = i;
            end;
            
            
        else % not an operator
            
            % symbols outside brackets
            if (isempty(output))
                output = c;
            else
                output = strcat(output, c);
            end;
        end;
        
    else
        %inbetween brackets
        if (isempty(output))
            output = c;
        else
            output = strcat(output, c);
        end;
    end;
end;
% catch last symbol that is not followed by an operator
if (~isempty(output))
    NoSubFunctions = NoSubFunctions + 1;
    ArrayFunctions{NoSubFunctions} = output;
    output = '';
end; 

%-------------------------------------------------------------------------
% now have an array containing functions
% and an array of operators between them

% check correct numbers
if (NoSubFunctions-1 > NoOperators || NoOperators > NoSubFunctions)
    error('charFormula2sym(input)\n%s\n%s%i\n%s%i','Invalid formula - CANNOT convert', 'No Subfunctions = ', NoSubFunctions, 'No Operators =', NoOperators);
end;

%-------------------------------------------------------------------------
% convert each subfunction to a symbolic expression
% add to a second array
% save all symbols
SymArray = [];
for i = 1:NoSubFunctions
    [Formula, Symbols] = ConvertToSym(ArrayFunctions{i});
    FormulaArray(i) = Formula;
    SymArray = [SymArray, Symbols];
end;

%-------------------------------------------------------------------------
% deal with leading operator
if (bLeadingOperator)
   switch (OperatorArray(1))
       case '-'
          FormulaArray(1) = - FormulaArray(1);
       case '+'
       case '*'
       case '/'
       case '^'
          error ('inaccurate formula');
    end;
    
    % remove leading operator from the array of operators
    for i = 1:NoOperators-1
        OperatorArray(i) = OperatorArray(i+1);
    end;
    OperatorArray(NoOperators) = [];
end;

% record the index of each type of operator
% catch case where formula was a single bracketed expression
if (NoOperators == 0)
    PlusIndex = [];
    MinusIndex = [];
    MultIndex = [];
    DivIndex = [];
    ExpIndex = [];
else
    PlusIndex = find(ismember(OperatorArray, '+') == 1);
    MinusIndex = find(ismember(OperatorArray, '-') == 1);
    MultIndex = find(ismember(OperatorArray, '*') == 1);
    DivIndex = find(ismember(OperatorArray, '/') == 1);
    ExpIndex = find(ismember(OperatorArray, '^') == 1);
end;
% -------------------------------------------------------------------------
% write symbolic formula

Formula = WriteFormula(FormulaArray, ExpIndex, MultIndex, DivIndex, PlusIndex, MinusIndex);

%-------------------------------------------------------------------
% assign outputs

y  = Formula;
z  = RemoveDuplicates(SymArray);

%**************************************************************************
% FUNCTION: ConvertToSym
%**************************************************************************

function [y,z] = ConvertToSym(charArray)
% ConvertToSym(charArray) converts a char array that represents a mathematical formula
% to a symbolic representation of that formula
% 
% returns 
%     1) the symbolic representation of the formula as first output argument
%     2) an array of the symbols used within the formula as second output
%     argument
%
% NOTE: ConvertToSym should only be called for a single expression
%       of the form a op1 b op2 c etc.
%       where a, b and c are either numbers or symbols
%       and op is an arithmetic operator: +  - * / ^
%       i.e. NO brackets
%
%------------------------------------------------------------
% EXAMPLE: [x,y] = ConvertToSym('a1*b*a1+a1/b-c^2')
%           x   =   a1^2*b+a1/b-c^2
%           y   =   [a1, b, c]
%------------------------------------------------------------

% allowed operators
OperatorLookup = '+-*/^';

% table of digits
Digits = '0123456789.-';

%------------------------------------------------------------
% check appropriate input
% i.e.  array of chars
%       no brackets

if (~ischar(charArray))
    error('ConvertToSym(input)\n%s', 'input must be an array of characters');
elseif (ismember('(', charArray) || ismember(')', charArray))
    error('ConvertToSym(input)\n%s', 'input should not contain brackets');
elseif (isempty(charArray))
    varargout{1} = [];
    varargout{2} = [];
    return;
end;

%--------------------------------------------------------------------
%lose white space in the character array
charArray = LoseWhiteSpace(charArray);

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

%-------------------------------------------------------------
% create an array that indicates whether elements of the input 
% are operators and determine number of operators

Operators = ismember(charArray, OperatorLookup);
NoOperators = sum(Operators);
OperatorIndex = find(Operators == 1);

% create an array of operators - excluding leading operator
% and excluding any negative numbers
if (NoOperators ~= 0)
    if (OperatorIndex(1) == 1)
        Start = 2;
        OperatorArray = [];
    else
        Start = 1;
    end;

    for i = length(OperatorIndex):-1:Start+1
        if ((OperatorIndex(i) - OperatorIndex(i-1))== 1)
            for j = i:length(OperatorIndex) - 1
                OperatorIndex(j) = OperatorIndex(j+1);
            end;
            OperatorIndex(length(OperatorIndex)) = [];
            NoOperators = NoOperators - 1;
        end;
    end;
    
    CountOperators = 0;
    for i = Start:length(OperatorIndex)
        CountOperators = CountOperators+1;
        OperatorArray(CountOperators) = charArray(OperatorIndex(i));
    end;
    
    % record the index of each type of operator
    PlusIndex = find(ismember(OperatorArray, '+') == 1);
    MinusIndex = find(ismember(OperatorArray, '-') == 1);
    MultIndex = find(ismember(OperatorArray, '*') == 1);
    DivIndex = find(ismember(OperatorArray, '/') == 1);
    ExpIndex = find(ismember(OperatorArray, '^') == 1);
else
    PlusIndex = [];
    MinusIndex = [];
    MultIndex = [];
    DivIndex = [];
    ExpIndex = [];
end;
%------------------------------------------------------------
% write an array of the symbols used in the expression
% keep a record of any symbols that are numeric
% check that the input is not a single symbol with no operator
NoSymbols = 0;
NoNumerics = 0;

if (NoOperators == 0)
    bLeadingOperator = 0;
    NoSymbols = 1;
    output = '';
    % write the symbol to the output
    for i = 1:NoChars
        c = charArray(i);
        output = strcat(output, c);
    end;
    
    % put the output into an array as a cell
    % if it is a number keep a note of the symbol No
    newCharArray{NoSymbols} = output;
    if (ismember(output, Digits))
        NoNumerics = NoNumerics + 1;
        ArrayDigitIndex(NoNumerics) = NoSymbols;
    end;
    
    
else
    % not a single symbol
    %-------------------------------------------------------------
    % loop through the array 
    %   (1) to determine symbols
    %   (2) check whether there is a leading operator i.e. -a*...
    %   (3) determine if any part of the formula is numeric
    
    % check whether there is a leading operator
    % and determine index of the first symbol
    if (OperatorIndex(1) == 1)
        bLeadingOperator = 1;
        CountOp = 2;
        SymStart = 2;
    else
        bLeadingOperator = 0;
        CountOp = 1;
        SymStart = 1;
    end;
    
    % determine each symbol and write it to an array
    while (CountOp <= NoOperators+1)
        NoSymbols = NoSymbols + 1;
        output = '';
        
        % get start and end point for each symbol
        if (CountOp > NoOperators)
            SymEnd = NoChars;
        else
            SymEnd = OperatorIndex(CountOp) - 1;
        end;
        
        % write the symbol to the output
        for i = SymStart:SymEnd
            c = charArray(i);
            if (isempty(output))
                output = c;
            else
                output = strcat(output, c);
            end;
        end;
        
        % put the output into an array as a cell
        % if it is a number keep a note of the symbol No
        newCharArray{NoSymbols} = output;
        if (sum(ismember(output, Digits)) == length(output))
            NoNumerics = NoNumerics + 1;
            ArrayDigitIndex(NoNumerics) = NoSymbols;
        end;
        
        % count on the operator and symbol starting place for next symbol
        if (CountOp <= NoOperators)
            SymStart = OperatorIndex(CountOp) + 1;
        end;
        CountOp = CountOp + 1;
    end;
end;

%-------------------------------------------------------------
% check that number of Symbols and operators is consistent
if (NoSymbols < NoOperators || NoSymbols > NoOperators+1)
    error('ConvertToSym(input)\n%s\n%s%i\n%s%i','Invalid formula - CANNOT convert', 'No Symbols = ', NoSymbols, 'No Operators =', NoOperators);
end;

% create the array of symbols used
for i = 1:NoSymbols
    ArraySyms(i) = sym(newCharArray{i});
end;

% include the leading operator within the first symbol
if (bLeadingOperator)
   switch (charArray(OperatorIndex(1)))
       case '-'
          ArraySyms(1) = - ArraySyms(1);
       case '+'
       case '*'
       case '/'
       case '^'
          error ('inaccurate formula');
    end;
end;

% -------------------------------------------------------------------------
% write symbolic formula

Formula = WriteFormula(ArraySyms, ExpIndex, MultIndex, DivIndex, PlusIndex, MinusIndex);
%------------------------------------------------------------------
% remove any numbers from the array of symbols
if (NoNumerics > 0)
    if (NoOperators == 0)
        NewArraySyms = [];
    elseif (bLeadingOperator == 1 && NoSymbols == 1)
        NewArraySyms = [];
    else
        NewArrayCount = 1;
        for i = 1:NoSymbols
            if (~ismember(i, ArrayDigitIndex))
                NewArraySyms(NewArrayCount) = ArraySyms(i);
                NewArrayCount = NewArrayCount + 1;
            end;
        end;  
        % catch case where all symbols in the array are numbers
        if (NewArrayCount == 1)
            NewArraySyms = [];
        end;
    end;
else
    NewArraySyms = ArraySyms;
end;

%-------------------------------------------------------------------
% assign outputs

y = Formula;
z = RemoveDuplicates(NewArraySyms);

%**********************************************************************
% FUNCTION: WriteFormula
% takes the array of symbols and the index of each operator and constructs 
% the symbolic formula
%**********************************************************************
function Formula = WriteFormula(ArraySyms, ExpIndex, MultIndex, DivIndex, PlusIndex, MinusIndex);

NoSymbols = length(ArraySyms);

if (NoSymbols == 1)
    Formula = ArraySyms(1);
else
    % replace a symbol with the function of the itself and the next symbol
    % move the array forward
    % adjust any operator index affected
    % e.g.          sym1            op1 sym2            op2 sym3           op3 sym4
    %       becomes sym1            op1 sym2            op2 (sym3 op3 sym4)
    %       and     (sym1 op1 sym2) op2 (sym3 op3 sym4)
    
% -------------------------------------------------------------------------
    % deal with any exponents first
    if (~isempty(ExpIndex))
        for i = length(ExpIndex):-1:1
            Start = ExpIndex(i);
            ArraySyms(Start) = ArraySyms(Start) ^ ArraySyms(Start+1);
            
            % move array of symbols forward
            NoSymbols = NoSymbols - 1;
            for j = Start+1:NoSymbols
                ArraySyms(j) = ArraySyms(j+1);
            end;
            ArraySyms(NoSymbols+1) = [];
            
            % adjust the index of any other operators
            for j = 1:length(DivIndex)
                if (DivIndex(j) > ExpIndex(i))
                    DivIndex(j) = DivIndex(j) - 1;
                end;
            end;
            for j = 1:length(MultIndex)
                if (MultIndex(j) > ExpIndex(i))
                    MultIndex(j) = MultIndex(j) - 1;
                end;
            end;
            for j = 1:length(PlusIndex)
                if (PlusIndex(j) > ExpIndex(i))
                    PlusIndex(j) = PlusIndex(j) - 1;
                end;
            end;
            for j = 1:length(MinusIndex)
                if (MinusIndex(j) > ExpIndex(i))
                    MinusIndex(j) = MinusIndex(j) - 1;
                end;
            end;
        end;
    end;
    
 % -------------------------------------------------------------------------
   % then division
    if (~isempty(DivIndex))
        for i = length(DivIndex):-1:1
            Start = DivIndex(i);
            ArraySyms(Start) = ArraySyms(Start) / ArraySyms(Start+1);

            % move array of symbols forward
            NoSymbols = NoSymbols - 1;
            for j = Start+1:NoSymbols
                ArraySyms(j) = ArraySyms(j+1);
            end;
            ArraySyms(NoSymbols+1) = [];
            
            % adjust the index of any other operators
            for j = 1:length(MultIndex)
                if (MultIndex(j) > DivIndex(i))
                    MultIndex(j) = MultIndex(j) - 1;
                end;
            end;
            for j = 1:length(PlusIndex)
                if (PlusIndex(j) > DivIndex(i))
                    PlusIndex(j) = PlusIndex(j) - 1;
                end;
            end;
            for j = 1:length(MinusIndex)
                if (MinusIndex(j) > DivIndex(i))
                    MinusIndex(j) = MinusIndex(j) - 1;
                end;
            end;
        end;
    end;

% -------------------------------------------------------------------------
    % then multiplication
    if (~isempty(MultIndex))
        for i = length(MultIndex):-1:1
            Start = MultIndex(i);
            ArraySyms(Start) = ArraySyms(Start) * ArraySyms(Start+1);
            
            % move array of symbols forward
            NoSymbols = NoSymbols - 1;
            for j = Start+1:NoSymbols
                ArraySyms(j) = ArraySyms(j+1);
            end;
            ArraySyms(NoSymbols+1) = [];
            
            % adjust the index of any other operators
            for j = 1:length(PlusIndex)
                if (PlusIndex(j) > MultIndex(i))
                    PlusIndex(j) = PlusIndex(j) - 1;
                end;
            end;
            for j = 1:length(MinusIndex)
                if (MinusIndex(j) > MultIndex(i))
                    MinusIndex(j) = MinusIndex(j) - 1;
                end;
            end;
        end;
    end;
    
% -------------------------------------------------------------------------
    % then subtraction
    if (~isempty(MinusIndex))
        for i = length(MinusIndex):-1:1
            Start = MinusIndex(i);
            ArraySyms(Start) = ArraySyms(Start) - ArraySyms(Start+1);
            % move array of symbols forward
            NoSymbols = NoSymbols - 1;
            for j = Start+1:NoSymbols
                ArraySyms(j) = ArraySyms(j+1);
            end;
            ArraySyms(NoSymbols+1) = [];
            
            % adjust the index of any other operators
             for j = 1:length(PlusIndex)
                if (PlusIndex(j) > MinusIndex(i))
                    PlusIndex(j) = PlusIndex(j) - 1;
                end;
            end;
       end;
    end;
    
% -------------------------------------------------------------------------
    % finally addition
    if (~isempty(PlusIndex))
        for i = length(PlusIndex):-1:1
            Start = PlusIndex(i);
            ArraySyms(Start) = ArraySyms(Start) + ArraySyms(Start+1);
            % move array of symbols forward
            NoSymbols = NoSymbols - 1;
            for j = Start+1:NoSymbols
                ArraySyms(j) = ArraySyms(j+1);
            end;
            ArraySyms(NoSymbols+1) = [];
        end;
    end;
    
% -------------------------------------------------------------------------
    % there should only be one symbolic expression left in the array 
    % which is the formula
    if (NoSymbols ~=1)
        error('NOT RIGHT');
    end;
    Formula = ArraySyms(1);
end;   

%**********************************************************************
% CheckNestedBrackets(charArray) takes an array of characters 
% and returns 
%       1 if the array contains nested brackets
%       0 otherwise
%**********************************************************************

function y = CheckNestedBrackets(charArray)

%------------------------------------------------------------
% check input is an array of characters
if (~ischar(charArray))
    error('CheckNestedBrackets(input)\n%s', 'input must be an array of characters');
end;

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

% begin outside a bracket
bInsideBracket = 0;
y = 0;

% loop thru the array 
for i = 1:NoChars
    c = charArray(i);
    
    %check whether the character is a bracket
    %c is an opening bracket
    if (c == '(')
        
        % check wether we are already inside a set of brackets
        if (bInsideBracket == 1)
            % already inside bracket
            % so there must be nesting
            y = 1;
            return;
        else
            bInsideBracket = 1;
        end;
        
    % c is a closing bracket
    elseif(c == ')')

        % check wether we are already inside a set of brackets
        if(bInsideBracket == 1)
            % already inside bracket
            % so now we are outside
            bInsideBracket = 0;
        else
            % not inside a bracket
            % so this bracket is incorrect
            y = 1;
            return;
        end;
    end;
end;

%**********************************************************************
% LoseWhiteSpace(charArray) takes an array of characters
% and returns the array with any white space removed
%
%**********************************************************************

function y = LoseWhiteSpace(charArray)
% LoseWhiteSpace(charArray) takes an array of characters
% and returns the array with any white space removed
%
%----------------------------------------------------------------
% EXAMPLE:
%           y = LoseWhiteSpace('     exa  mp le')
%           y = 'example'
%

%------------------------------------------------------------
% check input is an array of characters
if (~ischar(charArray))
    error('LoseWhiteSpace(input)\n%s', 'input must be an array of characters');
end;

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

%-------------------------------------------------------------
% create an array that indicates whether the elements of charArray are
% spaces
% e.g. WSpace = isspace('  v b') = [1, 1, 0, 1, 0]
% and determine how many

WSpace = isspace(charArray);
NoSpaces = sum(WSpace);

%-----------------------------------------------------------
% rewrite the array to leaving out any spaces
% remove any numbers from the array of symbols
if (NoSpaces > 0)
    NewArrayCount = 1;
    for i = 1:NoChars
        if (~isspace(charArray(i)))
            y(NewArrayCount) = charArray(i);
            NewArrayCount = NewArrayCount + 1;
        end;
    end;    
else
    y = charArray;
end;

