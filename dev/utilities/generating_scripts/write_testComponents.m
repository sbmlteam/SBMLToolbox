function write_testComponents

Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
   'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
    'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
     'Model', 'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
      'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
       'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
        'Unit', 'UnitDefinition'};

filename = sprintf('testComponents.m');
fileOut = fopen(filename, 'w');
fprintf(fileOut, 'function [fail] = testComponents()\n');

% put in header and licence
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% testComponents\n'); 
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%    returns\n'); 
fprintf(fileOut, '%%      the number of fails\n');

fprintf(fileOut, '%%  Filename    :   testComponents.m\n');
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

for i=1:length(Objects)
  fprintf(fileOut, '[f, n, m] = test%s;\n', Objects{i});
  fprintf(fileOut, 'fail = fail + f;\n');
  fprintf(fileOut, 'num = num + n;\n');
end;

fprintf(fileOut, '\ndisp(sprintf(''Number tests: %%d'', num));\n');
fprintf(fileOut, 'disp(sprintf(''Number fails: %%d'', fail));\n');
fprintf(fileOut, 'disp(sprintf(''Pass rate: %%d%%'', ((num-fail)/num)*100));\n\n');
fclose(fileOut);

