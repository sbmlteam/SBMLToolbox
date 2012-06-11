function outputSBMLFromFile(mfilename, sbmlfilename)

model = createSBMLModelFromODEFile(mfilename);

OutputSBML(model, sbmlfilename);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SBML = createSBMLModelFromODEFile(filename)

% hard code level and version
level = 3;
version = 1;

model = parseODEFile(filename);

% check that the model structure has all the information needed
if ~isfield(model, 'name') || ~isfield(model, 'xdotFuncs')
  reportProblem('ode function was not found');
elseif ~isfield(model, 'numVariables')
  reportProblem('number of variables was not found');
elseif ~isfield(model, 'initConds')
  reportProblem('initial conditions were not found');
elseif ~isfield(model, 'constantNames') || ~isfield(model, 'constantValues')
  reportProblem('constants were not found');
end;

SBML = Model_create(level, version);

for i = 1:length(model.constantNames)
  SBML = Model_createParameter(SBML);
  SBML.parameter(i) = Parameter_setId(SBML.parameter(i), model.constantNames{i});
  SBML.parameter(i) = Parameter_setValue(SBML.parameter(i), model.constantValues{i});
  SBML.parameter(i) = Parameter_setConstant(SBML.parameter(i),1);
end;

index = length(SBML.parameter);

for i = 1+index:model.numVariables+index
  SBML = Model_createParameter(SBML);
  SBML.parameter(i) = Parameter_setId(SBML.parameter(i), ...
                                      strcat(model.name, '_',num2str(i-index)));
  SBML.parameter(i) = Parameter_setValue(SBML.parameter(i), ...
                                      model.initConds(i-index));
  SBML.parameter(i) = Parameter_setConstant(SBML.parameter(i),0);
end;
 
for i = 1:model.numVariables
  RR = RateRule_create(level, version);
  RR = RateRule_setVariable(RR, strcat(model.name, '_',num2str(i)));
  RR = RateRule_setFormula(RR, model.xdotFuncs{i});
  SBML = Model_addRule(SBML, RR); 
end;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function reportProblem(problem)

error('%s\n%s%s\n%s\n%s\n%s\n%s', problem, 'the m file containing the odes must be tagged ', ...
  'with the following tags:', '% SBML - begin init conds', ...
  '% SBML - begin constants', '% SBML - begin ode declaration', ...
  '% SBML - begin ode function');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
  equalSign = strfind(line, '=');
  if length(equalSign) > 1 || ~strcmp(line(end), ';')
    error('%s%s', 'currently this function expects the constants ', ...
      'to be on lines of form name=value;');
  end;
  names{i} = line(1:equalSign-1);
  try
    values{i} = eval(line(equalSign+1:end-1));
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


