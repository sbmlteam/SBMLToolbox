function pairs = PairBrackets(formula)

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

for i = 1:length(pairs)
    pairs(i, 1) = TempPairs(i, 1);
    j = find(OriginalPairs == pairs(i, 1));
    pairs(i, 2) = OriginalPairs(j, 2);
end;
