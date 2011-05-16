function writeStruct(name)

doneFields = {'typecode', 'notes', 'annotation'};

fields = getFieldnames(name, 1, 1);
values = getDefaultValues(name, 1, 1);
doneFields = writeFields(name, fields, values, doneFields);

for vers = 1:4
  fields = getFieldnames(name, 2, vers);
  values = getDefaultValues(name, 2, vers);
  doneFields = writeFields(name, fields, values, doneFields);
end;
fields = getFieldnames(name, 3, 1);
values = getDefaultValues(name, 3, 1);
doneFields = writeFields(name, fields, values, doneFields);

function df = writeFields(name, fields, values, df)

singleObj = {'kineticLaw', 'trigger', 'delay', 'priority', 'stoichiometryMath'};
for i=1:length(fields)
  f = fields{i};
  if ~isIn(df, f)
    v = values{i};
    if (~isIn(singleObj, f) && ~ischar(v) && isempty(v))
      writeGetStruct(name, f);
      writeGetNumStruct(name, f);
      writeAddStruct(name, f);
      writeGetListOfStruct(name, f);
    else
      writeGet(name, f);
      if isnan(v)
        writeSetNum(name, f);
        writeUnsetNum(name, f);
        writeIsset(name, f);
      elseif isinteger(v)
        if (v == 0)
          writeSetBool(name, f);
        else
          writeSetNum(name, f);
          writeUnsetNum(name, f);
        end;
        writeIsset(name, f);
      elseif isnumeric(v)
        writeSetNum(name, f);
        writeUnsetNum(name, f);
        writeIsset(name, f);
      else
        writeSet(name, f);
        writeIssetString(name, f);
        writeUnsetString(name, f);
      end;
    end;
    df{end+1} = f;
  end;
end;






function value = isIn(array, thing)

value = sum(ismember(array, thing));