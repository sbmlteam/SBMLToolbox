function writeStructDocs

Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
   'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
    'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
     'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
      'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
       'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
        'Unit', 'UnitDefinition'};

for i=1:length(Objects)
  writeDoc(Objects{i});
end;

function writeDoc(obj)

name = strcat(lower(obj), '.html');


fOut = fopen(name, 'w');

fprintf(fOut, '<LINK href=\"style.css\" rel=\"stylesheet\" type="text/css\">\n');

fprintf(fOut, '\n\n<a name=\"%s\"></a>\n', obj);
fprintf(fOut, '<h3> %s </h3>\n', obj);
values = getDefaultValues(obj, 2, 4);
if isempty(values)
  values = getDefaultValues(obj, 1, 2);
end;
if isempty(values)
  values = getDefaultValues(obj, 3, 1);
end;
fprintf(fOut, '<p>typecode = %s</p><br/>', values{1});
writeOutertable(fOut);
fprintf(fOut, '\t<tr>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 1, 1);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 1, 2);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 1);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 2);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 3);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 2, 4);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t\t<td>\n');
writeTable(fOut, obj, 3, 1);
fprintf(fOut, '\t\t</td>\n');
fprintf(fOut, '\t</tr>\n');
fprintf(fOut, '</table>\n');
fprintf(fOut, '</center>\n');

fclose(fOut);

function writeOutertable(fout)

fprintf(fout, '<center>\n\n<table class=\"borderless-table sm-padding\" width=\"90%%\">\n');
fprintf(fout, '\t<tr class=\"headers2\">\n\t\t<td>SBML Level 1 Version 1</td>\n');
fprintf(fout, '\t\t<td>SBML Level 1 Version 2</td>\n');
fprintf(fout, '\t\t<td>SBML Level 2 Version 1</td>\n');
fprintf(fout, '\t\t<td>SBML Level 2 Version 2</td>\n');
fprintf(fout, '\t\t<td>SBML Level 2 Version 3</td>\n');
fprintf(fout, '\t\t<td>SBML Level 2 Version 4</td>\n');
fprintf(fout, '\t\t<td>SBML Level 3 Version 1</td>\n');
fprintf(fout, '\t</tr>\n');

function writeTable(fout, obj, l, v)

[fieldnames, num] = getFieldnames(obj, l, v);
if (num == 0)
  fprintf(fout, 'N/A\n');
  return;
end;
values = getDefaultValues(obj, l, v);
fprintf(fout, '\t\t\t<!-- Level %u Version %u -->\n', l, v);
fprintf(fout, '\t\t\t<center>\n');
fprintf(fout, '\t\t\t\t<table class=\"borderless-table gray-border sm-padding sm-font alt-row-colors\"\n');
fprintf(fout, '\t\t\t\t       width=\"35%%\" cellspacing=\"1\" cellpadding=\"2\" border=\"0\">\n');
fprintf(fout, '\t\t\t\t\t<tr class=\"headers\">\n');
fprintf(fout, '\t\t\t\t\t\t<td class=\"struct\">Fieldname</td>\n');
fprintf(fout, '\t\t\t\t\t\t<td class=\"type\">Type</td>\n');
fprintf(fout, '\t\t\t\t\t</tr>\n');
for i = 1:length(fieldnames)
  fprintf(fout, '\t\t\t\t\t<tr>\n');
  fprintf(fout, '\t\t\t\t\t\t<td> %s </td>\n', fieldnames{i});
  fprintf(fout, '\t\t\t\t\t\t<td> %s </td>\n', getType(values{i}));
  fprintf(fout, '\t\t\t\t\t</tr>\n');
end;
fprintf(fout, '\t\t\t\t</table>\n');
fprintf(fout, '\t\t\t</center>\n');

function type = getType(value)

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
else
  type = 'double';
end;
  
