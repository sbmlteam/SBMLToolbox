function writeStructDocs
% writes the html for the structure fields
% should be called from the doc/structure dir



[top, a] = fileparts(pwd);
if ~strcmp(a, 'structure')
  error('need to be in docs/structure directory');
else
  [c, d] = fileparts(top);
  if ~strcmp(d, 'docs')
    error('need to be in docs/structure directory');
  end;
end;

Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
   'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
    'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
     'Model', 'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
      'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
       'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
        'Unit', 'UnitDefinition'};


for i=1:length(Objects)
  writeDoc(Objects{i});
end;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function writeDoc(obj)

name = strcat(lower(obj), '.html');


fOut = fopen(name, 'w');

%fprintf(fOut, '<LINK href=\"style.css\" rel=\"stylesheet\" type="text/css\">\n');
fprintf(fOut, '<style type=''text/css''>\n');  
fprintf(fOut, '/*/*/ /*<![CDATA[*/\n'); 
fprintf(fOut, '@import "../style.css";\n'); 
fprintf(fOut, '/*]]>*/ /* */ \n');
fprintf(fOut, '</style>\n\n');
% write the Object name as header with an anchor
fprintf(fOut, '\n\n<a name=\"%s\"></a>\n', obj);
fprintf(fOut, '<center>\n<h2> %s </h2>\n', obj);

% get the typecode for the object and write it out
% double check we have got it since not every object exists in every level/version
values = getDefaultValues(obj, 2, 4);
if isempty(values)
  values = getDefaultValues(obj, 1, 2);
end;
if isempty(values)
  values = getDefaultValues(obj, 3, 1);
end;
fprintf(fOut, '<p>typecode = %s</p><br/>\n</center>', values{1});

% For each level
% create the outer table with the level/version headers
fprintf(fOut, '\n\n<br/><br/>\n\n');
writeOutertable(fOut, 1, 1);
fprintf(fOut, '\t<tr valign=\"top\">\n');

% inside this outer table inside each column write the table for the appropriate level/version 
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 1, 1);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 1, 2);
fprintf(fOut, '\t\t</td>\n');

% close the outer table
fprintf(fOut, '\t</tr>\n');
fprintf(fOut, '</table>\n');
fprintf(fOut, '</center>\n');

fprintf(fOut, '\n\n<br/><br/>\n\n');
writeOutertable(fOut, 2, 1);
fprintf(fOut, '\t<tr valign=\"top\">\n');

fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 1);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 2);
fprintf(fOut, '\t\t</td>\n');

% close the outer table
fprintf(fOut, '\t</tr>\n');
fprintf(fOut, '</table>\n');
fprintf(fOut, '</center>\n');

fprintf(fOut, '\n\n<br/><br/>\n\n');
writeOutertable(fOut, 2, 3);
fprintf(fOut, '\t<tr valign=\"top\">\n');

fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 3);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 4);
fprintf(fOut, '\t\t</td>\n');

% close the outer table
fprintf(fOut, '\t</tr>\n');
fprintf(fOut, '</table>\n');
fprintf(fOut, '</center>\n');

fprintf(fOut, '\n\n<br/><br/>\n\n');
writeOutertable(fOut, 3, 1);
fprintf(fOut, '\t<tr valign=\"top\">\n');

fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 3, 1);
fprintf(fOut, '\t\t</td>\n');


% close the outer table
fprintf(fOut, '\t</tr>\n');
fprintf(fOut, '</table>\n');
fprintf(fOut, '</center>\n');

fclose(fOut);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write the top of the outer table with level/version headers
function writeOutertable(fout, level, ver)

if level == 1
  width = 50;
elseif level == 2
  width = 50;
else
  width = 35;
end;
%fprintf(fout, '<h2>SBML Level %u</h2>\n', level);
if (ver < 3)
fprintf(fout, '<center>\n\n<h2>SBML Level %u</h2>\n\n<table class=\"borderless-table sm-padding\" width=\"%u%%\">\n', level, width);
else
fprintf(fout, '<center>\n<table class=\"borderless-table sm-padding\" width=\"%u%%\">\n', level, width);
end;
if (ver == 1)
  fprintf(fout, '\t<tr class=\"headers2\">\n\t\t<td>Version 1</td>\n');
  if level < 3
  fprintf(fout, '\t\t<td>Version 2</td>\n');
  end;
else
  fprintf(fout, '\t<tr class=\"headers2\">\n\t\t<td>Version 3</td>\n');
  fprintf(fout, '\t\t<td>Version 4</td>\n');
end;
fprintf(fout, '\t</tr>\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% write the table for the given level and version
function writeTable(fout, obj, l, v)

[fieldnames, num] = getFieldnames(obj, l, v);
if (num == 0)
  fprintf(fout, 'The %s component is not part of SBML Level %u Version %u\n', obj, l, v);
  return;
end;
values = getDefaultValues(obj, l, v);
fprintf(fout, '\t\t\t<!-- Level %u Version %u -->\n', l, v);
fprintf(fout, '\t\t\t<center>\n');
fprintf(fout, '\t\t\t\t<table class=\"borderless-table gray-border sm-padding sm-font alt-row-colors\"\n');
fprintf(fout, '\t\t\t\t       width=\"35%%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">\n');
fprintf(fout, '\t\t\t\t\t<tr class=\"headers\">\n');
fprintf(fout, '\t\t\t\t\t\t<th class=\"struct\">Fieldname</th>\n');
fprintf(fout, '\t\t\t\t\t\t<th class=\"type\">Type</th>\n');
fprintf(fout, '\t\t\t\t\t</tr>\n');
  fprintf(fout, '\t\t\t\t\t<tr>\n');
  fprintf(fout, '\t\t\t\t\t\t<td><code> %s </code></td>\n', fieldnames{1});
  fprintf(fout, '\t\t\t\t\t\t<td> as above </td>\n');
  fprintf(fout, '\t\t\t\t\t</tr>\n');
for i = 2:length(fieldnames)
  fprintf(fout, '\t\t\t\t\t<tr>\n');
  type = getType(values{i}, fieldnames{i}, l, v);
  if ~strcmp(type, 'structure') && ~strcmp(type, 'array of structures')
    fprintf(fout, '\t\t\t\t\t\t<td><code> %s </code></td>\n', fieldnames{i});
    fprintf(fout, '\t\t\t\t\t\t<td> %s </td>\n', type);
    fprintf(fout, '\t\t\t\t\t</tr>\n');
  else
    fprintf(fout, '\t\t\t\t\t\t<td><a href="%s.html">%s</a></td>\n', fieldnames{i}, fieldnames{i});
    fprintf(fout, '\t\t\t\t\t\t<td> %s </td>\n', type);
    fprintf(fout, '\t\t\t\t\t</tr>\n');
  end;
end;
fprintf(fout, '\t\t\t\t</table>\n');
fprintf(fout, '\t\t\t</center>\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% produce appropriate type information from the default value
function type = getType(value, name, l, v)

singleObj = {'kineticLaw', 'trigger', 'delay', 'priority', 'stoichiometryMath'};
stringObj = {'trigger', 'delay', 'stoichiometryMath'};

if isIn(singleObj, name)
  if (l == 2 && v < 3 && isIn(stringObj, name))
    type = 'string';
  else
  type = 'structure';
  end;
  return;
end;
if ischar(value)
  type = 'string';
elseif isinteger(value) && value == -1
  type = 'integer';
elseif isinteger(value) && value == 0
  type = 'boolean';
elseif isinteger(value) && value > 0
  type = 'integer';
elseif isnan(value)
  type = 'double';
elseif isempty(value)
  type = 'array of structures';
else
  type = 'double';
end;
  

function value = isIn(array, thing)

value = sum(ismember(array, thing));
