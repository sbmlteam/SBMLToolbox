function index = matchName(expr, name)

operators = '+-*/^)';
maxSize = length(expr);
tempIndex = strfind(expr, name);
index = [];
if ~isempty(tempIndex)
  % we found name - but is is followed by a math symbol
  for i=1:length(tempIndex)
    followIndex = tempIndex(i) + length(name);
    if (followIndex < maxSize)
      followChar = expr(followIndex);
      if ismember(followChar, operators)
        index = [index;tempIndex(i)];    
      end;
    else
      index = [index;tempIndex(i)];
    end;
  end;
end;
