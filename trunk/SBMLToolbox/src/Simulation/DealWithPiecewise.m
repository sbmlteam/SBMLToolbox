function Elements = DealWithPiecewise(OriginalFormula)

OriginalFormula = LoseWhiteSpace(OriginalFormula);

OpeningBracketIndex = find((ismember(OriginalFormula, '(')) == 1);

ClosingBracketIndex = find((ismember(OriginalFormula, ')')) == 1);

CommaIndex = find((ismember(OriginalFormula, ',')) == 1);

%pair the brackets
Pairs = PairBrackets(OriginalFormula);

Start = findstr(OriginalFormula, 'piecewise');

if (length(Start) ~= 1)
    error ('piecwise either does not occur or occurs more than once\n');
end;



% find the commas that are between the arguments of the piecwise expression
% not those that may be part of the argument
% e.g.  'piecewise(gt(d,e),lt(2,e),gt(f,d))'
%                         |       |       
%                      relevant commas

piecewiseBrackets = 1;
while(piecewiseBrackets <= length(OpeningBracketIndex))
    if (Pairs(piecewiseBrackets, 1) > Start)
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

    Elements{ElementNumber} = element;
    ElementNumber = ElementNumber + 1;

end;


element = '';
j = j+1;
while (j < Pairs(piecewiseBrackets, 2))
    element = strcat(element, OriginalFormula(j));
    j = j + 1;
end;

Elements{ElementNumber} = element;


% check for a sign in front of leading brackets
if (Pairs (1,1) ~= 1)
    if strcmp(OriginalFormula(1), '-')
        Elements{2} = strcat('-',Elements{2});
        Elements{3} = strcat('-',Elements{3});
    end;
end;
       
    


