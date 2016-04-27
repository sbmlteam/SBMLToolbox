function writeStruct(name)

doneFields = {'typecode', 'notes', 'annotation', 'level', 'version', 'fbc_version'};

% fields = getFieldnames(name, 1, 1);
% values = getDefaultValues(name, 1, 1);
% doneFields = writeFields(name, fields, values, doneFields);
% 
% for vers = 1:4
%   fields = getFieldnames(name, 2, vers);
%   values = getDefaultValues(name, 2, vers);
%   doneFields = writeFields(name, fields, values, doneFields);
% end;
for vers = 1:2
fields = getFieldnames(name, 3, 1, vers);
values = getDefaultValues(name, 3, 1, vers);
doneFields = writeFields(name, fields, values, doneFields);
end;


function df = writeFields(name, fields, values, df)

singleObj = {'kineticLaw', 'trigger', 'delay', 'priority', 'stoichiometryMath', 'association', ...
    'geneProductAssociation'};
for i=1:length(fields)
  f = fields{i};
  fullname = f;
  if length(f) > 4 && strcmp(f(1:4), 'fbc_')
    f = f(5:end);
  end;
  if ~isIn(df, f)
    v = values{i};
    if (~isIn(singleObj, f) && ~ischar(v) && isempty(v))
      writeGetStruct(name, f);
      writeGetNumStruct(name, f);
      writeAddStruct(name, f);
      writeGetListOfStruct(name, f);
    else
      writeGet(name, f, fullname);
      if isnan(v)
        writeSetNum(name, f, fullname);
        writeUnsetNum(name, f, fullname);
        writeIsset(name, f, fullname);
      elseif isinteger(v)
        if (v == 0)
          writeSetBool(name, f, fullname);
        else
          writeSetNum(name, f, fullname);
          writeUnsetNum(name, f, fullname);
        end;
        writeIsset(name, f, fullname);
      elseif isnumeric(v)
        writeSetNum(name, f, fullname);
        writeUnsetNum(name, f, fullname);
        writeIsset(name, f, fullname);
      else
        writeSet(name, f, fullname);
        writeIssetString(name, f, fullname);
        writeUnsetString(name, f, fullname);
      end;
    end;
    df{end+1} = f;
  end;
end;






function value = isIn(array, thing)

value = sum(ismember(array, thing));
