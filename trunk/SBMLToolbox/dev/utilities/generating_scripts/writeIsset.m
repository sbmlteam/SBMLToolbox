function writeIsset(name, attrib)

capAttrib = strcat(upper(attrib(1)), attrib(2:end));
newfilename = sprintf('%s_isSet%s.m', name, capAttrib);
fileOut = fopen(newfilename', 'w');

fprintf(fileOut, 'function value = %s_isSet%s(SBML%s)\n', name, capAttrib, name);

% put in header and licence
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% %s_isSet%s\n', name, capAttrib); 
fprintf(fileOut, '%%    takes an SBML %s structure\n', name);
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%    returns\n'); 
fprintf(fileOut, '%%      1 if the value for the %s attribute is set\n', attrib);
fprintf(fileOut, '%%      0 otherwise\n\n');


fprintf(fileOut, '%%  Filename    :   %s_isSet%s.m\n', name, capAttrib);
fprintf(fileOut, '%%  Description :\n');
fprintf(fileOut, '%%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>\n');
fprintf(fileOut, '%%  $Id: $\n');
fprintf(fileOut, '%%  $Source v $\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%<!---------------------------------------------------------------------------\n');
fprintf(fileOut, '%% This file is part of SBMLToolbox.  Please visit http://sbml.org for more\n');
fprintf(fileOut, '%% information about SBML, and the latest version of SBMLToolbox.\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Copyright (C) 2009-2011 jointly by the following organizations: \n');
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

fprintf(fileOut, '%%get level and version and check the input arguments are appropriate\n\n');
fprintf(fileOut, '[level, version] = GetLevelVersion(SBML%s);\n\n', name);

fprintf(fileOut, 'fieldnames = get%sFieldnames(level, version);\n\n', name);

fprintf(fileOut, 'if sum(ismember(fieldnames, ''isSet%s'')) > 0\n', capAttrib);
fprintf(fileOut, '\tvalue = SBML%s.isSet%s;\n', name, capAttrib);
fprintf(fileOut, 'else\n');
fprintf(fileOut, '\terror(''isSet%s not an attribute on SBML L%%dV%%d %s'', level, version);\n', ...
  capAttrib, name);
fprintf(fileOut, 'end;\n\n');

fclose(fileOut);

