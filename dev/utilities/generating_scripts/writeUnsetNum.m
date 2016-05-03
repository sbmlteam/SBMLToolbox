function writeUnsetNum(name, attrib, fullname)

capAttrib = strcat(upper(attrib(1)), attrib(2:end));
newfilename = sprintf('%s_unset%s.m', name, capAttrib);
fileOut = fopen(newfilename', 'w');

fprintf(fileOut, 'function SBML%s = %s_unset%s(SBML%s)\n', name, name, capAttrib, name);

% put in header and licence
fprintf(fileOut, '%% SBML%s = %s_unset%s(SBML%s)\n', name, name, capAttrib, name); 
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Takes\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% 1. SBML%s, an SBML %s structure\n', name, name);
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% Returns\n'); 
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% 1. the SBML FBC %s structure with the %s attribute unset\n', name, fullname);
fprintf(fileOut, '%%\n\n');


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

fprintf(fileOut, '%%get level and version and check the input arguments are appropriate\n\n');
fprintf(fileOut, '[level, version, pkgVersion] = GetFBCLevelVersion(SBML%s);\n\n', name);

fprintf(fileOut, 'if isfield(SBML%s, ''%s'')\n', name, fullname);
fprintf(fileOut, '\tSBML%s.%s = NaN;\n', name, fullname);
fprintf(fileOut, 'else\n');
fprintf(fileOut, '\terror(''%s not an attribute on SBML L%%dV%%d %s'', level, version);\n', ...
  attrib, name);
fprintf(fileOut, 'end;\n\n');

fclose(fileOut);

