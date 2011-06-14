function identical = areIdentical(struct1, struct2)

if ~isValid(struct1)
  error('first argument must be an SBML Structure');
elseif ~isValid(struct2)
  error('second argument must be an SBML Structure');
end;

identical = 1;

fields1 = fieldnames(struct1);
fields2 = fieldnames(struct2);

if length(fields1) ~= length(fields2)
  identical = 0;
end;

% fieldnames the same
if (identical)
  i = 1;
  while identical && i <= length(fields1)
    if ~strcmp(fields1{i}, fields2{i})
      identical = 0;
    end;
    i = i + 1;
  end;  
end;

%fieldvalues the same
if (identical)
  i = 1;
  while identical && i < length(fields1)
    value1 = getfield(struct1, fields1{i});
    value2 = getfield(struct2, fields1{i});
    if isstruct(value1)
      if length(value1) > 0 && ~areIdentical(value1, value2)
        identical = 0;
      end;
    elseif isnan(value1)
      if ~isnan(value2)
        identical = 0;
      end;
    elseif isnumeric(value1)
      if value1 ~= value2
        identical = 0;
      end;
    elseif ischar(value1)
      if ~strcmp(value1, value2)
        identical = 0;
      end;
    end;
    i = i + 1;
  end;
end;