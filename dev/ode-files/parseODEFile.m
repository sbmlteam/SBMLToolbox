function model = parseODEFile(filename)

% open file and check it is open
fileId = fopen(filename, 'r');
if (fileId == -1)
  error('file %s could not be opened', filename);
end;

model = struct([]);
% read each line and parse SBML tags
line = fgetl(fileId);
while ~feof(fileId)
 
  line = fgetl(fileId);
  

  if length(line) > 14 && strcmp(line(1:14), '% SBML - begin')
    model = parseSBMLTag(line, fileId, model);
  end;

end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
function model = parseSBMLTag(line, fileId, model)

if strcmp(line(16:end), 'init conds')
  nextline = fgetl(fileId);
  [model(1).numVariables, model(1).initConds] = getVariables(nextline);
  if ne(length(model(1).initConds), model(1).numVariables)
    error('mismatch in number of variables and number of initial conditions');
  end;
elseif strcmp(line(16:end), 'constants')
  [model(1).constantNames, model(1).constantValues] = getConstants(fileId);
elseif strcmp(line(16:end), 'ode declaration')
  nextline = fgetl(fileId);
  [model(1).name] = getXdotName(nextline);
elseif strcmp(line(16:end), 'ode function')
  nextline = fgetl(fileId);
  if ~isfield(model, 'name')
    error('function declaration has not been found');
  end;
  [model(1).xdotFuncs] = getXdotFunctions(nextline, model(1).name);
  if ne(length(model(1).xdotFuncs), model(1).numVariables)
    error('mismatch in number of variables and number of odes');
  end;
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function xdotFuncs = getXdotFunctions(line, name)

line = LoseWhiteSpace(line);
% assume we have a line name=[val1;val2]
openBracket = strfind(line, '[');
if length(openBracket) > 1
  error('%s%s', 'currently this function expects the ode function ', ...
    'to be on one line of form ode=[formula1;formula2; formula3]');
end;
closeBracket = strfind(line, ']');
if length(closeBracket) > 1
  error('%s%s', 'currently this function expects the ode function ', ...
    'to be on one line of form ode=[formula1;formula2; formula3]');
end;

subLine = line(openBracket+1:closeBracket-1);

% find semi colons between []
semiColons = strfind(subLine, ';');
numVariables = length(semiColons) + 1;

start = 1;
for i = 1:numVariables
  if le(i, length(semiColons))
    xdotFuncs{i} = subLine(start:semiColons(i)-1);
    start = semiColons(i)+1;
  else
    xdotFuncs{i} = subLine(start:end);
  end;
end;

% any of the x variables will occur as x(i)
% need to replace these with x_i
for i = 1:numVariables
  
  subLineA = xdotFuncs{i};
  
  brackets = PairBrackets(subLineA);
  nameBracket = strcat(name, '(');
  nameUnder = strcat(name, '_');
  
  vars = strfind(subLineA, nameBracket);
  
  subLineA = strrep(subLineA, nameBracket, nameUnder);

  for j = length(vars):-1:1
     [a, b] = find(brackets == vars(j)+1);
     if (b ~= 1)
       error('bracket mismatch');
     end;
     bb = brackets(a, 2);
     subLineA = strcat(subLineA(1:bb-1), ' ', subLineA(bb+1:end));   
  end;
  xdotFuncs{i} = subLineA;
end;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function name = getXdotName(line)

line = LoseWhiteSpace(line);
% should be functiony=g(t,x)

comma = strfind(line, ',');
if (ne(strfind(line, 'function'), 1) || ne(length(comma), 1) ...
    || ne(length(strfind(line, ')')), 1) || ~strcmp(line(end), ')'))
  error('%s%s', 'currently this function expects the function declaration ', ...
    'to be one line of form function name=(time, xdot)');
end;

name = line(comma+1:end-1);
  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%h(%%%%%%%%%%%%%%%%%%%%%%%
function [names, values] = getConstants(fileId)

i = 1;
names = [];
values = [];
line = LoseWhiteSpace(fgetl(fileId));

while(~strcmp(line, '%SBML-endconstants'))
  if length(line) == 0 || strcmp(line(1), '%')
    line = LoseWhiteSpace(fgetl(fileId));
    continue;
  end;
  equalSign = strfind(line, '=');
  terminateLine = strfind(line, ';');
  if length(equalSign) > 1 || length(terminateLine) > 1
    error('%s%s%s', 'currently this function expects the constants ', ...
      'to be on lines of form name=value; with only comments after the ;', ...
      'more than one = or ; found');
  elseif terminateLine < length(line) && ~strcmp(line(terminateLine+1), '%')
    error('%s%s%s', 'currently this function expects the constants ', ...
      'to be on lines of form name=value; with only comments after the ;', ...
      'the ; must be followed by a %');
  end;
  names{i} = line(1:equalSign-1);
  try
    values{i} = eval(line(equalSign+1:terminateLine-1));
  catch
    error('%s%s', 'currently this function expects the constants ', ...
      'to be on lines of form name=value;');
  end;
  i = i + 1;
  line = LoseWhiteSpace(fgetl(fileId));
end;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [numVariables, initConds] = getVariables(line)

% assume we have a line name=[val1;val2]
openBracket = strfind(line, '[');
if length(openBracket) > 1
  error('%s%s', 'currently this function expects the initial conditions ', ...
    'to be on one line of form name=[val1;val2; ...]');
end;
closeBracket = strfind(line, ']');
if length(closeBracket) > 1
  error(' %s%s', 'currently this function expects the initial conditions ', ...
    'to be on one line of form name=[val1;val2; ...]');
end;

% find semi colons between []
semiColons = strfind(line(openBracket:closeBracket), ';');

% reindex these to refer to whole string
semiColons = semiColons + openBracket - 1;

numVariables = length(semiColons) + 1;

start = openBracket + 1;
for i = 1:numVariables
  if le(i, length(semiColons))
    initConds(i) = str2double(line(start:semiColons(i)-1));
    start = semiColons(i)+1;
  else
    initConds(i) = str2double(line(start:closeBracket-1));
  end;
end;


