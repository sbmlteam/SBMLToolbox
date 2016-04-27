function writeFbcTest(name)

filename = sprintf('test%s.m', name);
fileOut = fopen(filename, 'w');
fprintf(fileOut, 'function [fail, num, message] = test%s()\n', name);

% put in header and licence
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% test%s\n', name); 
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%    returns\n'); 
fprintf(fileOut, '%%      the number of fails\n');
fprintf(fileOut, '%%      the number of tests\n');
fprintf(fileOut, '%%      and an array of any messages\n\n');

fprintf(fileOut, '%%  Filename    :   %test%s.m\n', name);
fprintf(fileOut, '%%  Description :\n');
fprintf(fileOut, '%%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>\n');
fprintf(fileOut, '%%  $Id: $\n');
fprintf(fileOut, '%%  $Source v $\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%<!---------------------------------------------------------------------------\n');
fprintf(fileOut, '%% This file is part of SBMLToolbox.  Please visit http://sbml.org for more\n');
fprintf(fileOut, '%% information about SBML, and the latest version of SBMLToolbox.\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Copyright (C) 2009-2016 jointly by the following organizations: \n');
fprintf(fileOut, '%%     1. California Institute of Technology, Pasadena, CA, USA\n');
fprintf(fileOut, '%%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Copyright (C) 2006-2008 jointly by the following organizations: \n');
fprintf(fileOut, '%%     1. California Institute of Technology, Pasadena, CA, USA\n');
fprintf(fileOut, '%%     2. University of Hertfordshire, Hatfield, UK\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Copyright (C) 2003-2005 jointly by the following organizations: \n');
fprintf(fileOut, '%%     1. California Institute of Technology, Pasadena, CA, USA \n');
fprintf(fileOut, '%%     2. Japan Science and Technology Agency, Japan\n');
fprintf(fileOut, '%%     3. University of Hertfordshire, Hatfield, UK\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% SBMLToolbox is free software; you can redistribute it and/or modify it\n');
fprintf(fileOut, '%% under the terms of the GNU Lesser General Public License as published by\n');
fprintf(fileOut, '%% the Free Software Foundation.  A copy of the license agreement is provided\n');
fprintf(fileOut, '%% in the file named "LICENSE.txt" included with this software distribution.\n');
fprintf(fileOut, '%%----------------------------------------------------------------------- -->\n\n\n');

% write variables
fprintf(fileOut, 'fail = 0;\n');
fprintf(fileOut, 'num = 0;\n');
fprintf(fileOut, 'message = {};\n');
fprintf(fileOut, 'warning(''off'', ''Warn:InvalidLV'');\n\n');
fprintf(fileOut, 'disp(''Testing %s'');\n\n', name);

ignoreFields = {'typecode', 'notes', 'annotation', 'level', 'version', 'fbc_version', 'isSetfbc_value'};

for vers = 1:2
%   fields = getFieldnames(name, 3, 1, vers);
%   values = getDefaultValues(name, 3, 1, vers);
  writeTests(name, 3, 1, vers, ignoreFields, fileOut);
end;



fprintf(fileOut, 'disp(sprintf(''Number tests: %%d'', num));\n');
fprintf(fileOut, 'disp(sprintf(''Number fails: %%d'', fail));\n');
fprintf(fileOut, 'disp(sprintf(''Pass rate: %%d%%'', ((num-fail)/num)*100));\n\n');

fprintf(fileOut, '\n\nwarning(''on'', ''Warn:InvalidLV'');\n');

fclose(fileOut);


function df = writeTests(name, level, vers, pkgver, df, fileOut)

fprintf(fileOut, 'disp(''Testing L%dV%d Fbc V%d'');\n', level, vers, pkgver);
fprintf(fileOut, 'obj = %s_create(%d, %d, %d);\n', name, level, vers, pkgver);
writeAttributes(name, level, vers, pkgver, df, fileOut);
fprintf(fileOut, '[fail, num, message] = testObject(obj, attributes, ''%s'', fail, num, message);\n\n', ...
  name);

function writeAttributes(name, level, vers, pkgver, ignore, fileOut)
fields = getFieldnames(name, level, vers, pkgver);
values = getDefaultValues(name, level, vers, pkgver);

len = length(fields);
fprintf(fileOut, 'attributes = {');
if (len == 0)
  fprintf(fileOut, '};\n');
  return;
end;


for i=1:len
  f = fields{i};
  if (strcmp(f, 'sboTerm'))
    capAttrib = strcat(upper(f(1:3)), f(4:end));
  else
    capAttrib = strcat(upper(f(1)), f(2:end));
  end;
  if ~isIn(ignore, f)
    v = values{i};
   fprintf(fileOut, '...\n              {');
    if isnan(v)
      fprintf(fileOut, '''%s'', 3}', capAttrib);
    elseif isinteger(v)
      if (v == 0)
        fprintf(fileOut, '''%s'', 5}', capAttrib);
      else
        fprintf(fileOut, '''%s'', 2}', capAttrib);
      end;
    elseif ~ischar(v) && isempty(v)
     fprintf(fileOut, '''%s'', 9}', capAttrib);
    elseif isnumeric(v)
      fprintf(fileOut, '''%s'', 4}', capAttrib);
    else
      fprintf(fileOut, '''%s'', 1}', capAttrib);
    end;
    ignore{end+1} = f;
  end;
end;
  fprintf(fileOut, '...\n             };\n');

function value = isIn(array, thing)

value = sum(ismember(array, thing));
