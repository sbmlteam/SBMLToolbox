function writeDV(name)

newfilename = sprintf('get%sDefaultValues.m', name);
fileOut = fopen(newfilename', 'w');

fprintf(fileOut, 'function [defaultValues] = get%sDefaultValues(level, version)\n', name);

% puit in header and licence
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% get%sDefaultValues\n', name); 
fprintf(fileOut, '%%    takes an SBML level\n');
fprintf(fileOut, '%%    and   an SBML version\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%    returns\n'); 
fprintf(fileOut, '%%      1) the default values for the structure represents\n');
fprintf(fileOut, '%%           an MATLAB_SBML %s structure of the appropriate\n', name);
fprintf(fileOut, '%%           level and version\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% The fields present in MATLAB_SBML %s structure of the appropriate\n', name);
fprintf(fileOut, '%% level and version can be found using get%sFieldnames(level, version)\n\n', name);

fprintf(fileOut, '%%  Filename    :   get%sDefaultValues.m\n', name);
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

fprintf(fileOut, '%%check the input arguments are appropriate\n\n');

fprintf(fileOut, 'if ~isValidLevelVersionCombination(level, version)\n');
fprintf(fileOut, '\terror(''invalid level/version combination'');\n');
fprintf(fileOut, 'end;\n\n');

fprintf(fileOut, 'if (level == 1)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 1, 1);
if (num == 0)
  fprintf(fileOut, '\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t                };\n');
end;

fprintf(fileOut, 'elseif (level == 2)\n');
fprintf(fileOut, '\tif (version == 1)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 2, 1);
if (num == 0)
  fprintf(fileOut, '\t\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\t\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t\t                };\n');
end;

fprintf(fileOut, '\telseif (version == 2)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 2, 2);
if (num == 0)
  fprintf(fileOut, '\t\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\t\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t\t                };\n');
end;

fprintf(fileOut, '\telseif (version == 3)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 2, 3);
if (num == 0)
  fprintf(fileOut, '\t\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\t\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t\t                };\n');
end;

fprintf(fileOut, '\telseif (version == 4)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 2, 4);
if (num == 0)
  fprintf(fileOut, '\t\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\t\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t\t                };\n');
end;
fprintf(fileOut, '\tend;\n');

fprintf(fileOut, 'elseif (level == 3)\n');
fprintf(fileOut, '\tif (version == 1)\n');
fhandle = sprintf('get%sFieldnames', name);
[fields, num] = feval(fhandle, 3, 1);
if (num == 0)
  fprintf(fileOut, '\t\tdefaultValues = [];\n');
else
  fprintf(fileOut, '\t\tdefaultValues = {\n');
  i = 1;
  while (i <= num)
    attr = getValue(fields{i}, name);
    if (ischar(attr))
      fprintf(fileOut, '\t\t\t               ''%s'', ...\n', attr);
    elseif (isinteger(attr))
      fprintf(fileOut, '\t\t\t               int32(%d), ...\n', attr);
    elseif (isnan(attr))
      fprintf(fileOut, '\t\t\t               0/0, ...\n');
    elseif (isempty(attr))
      fprintf(fileOut, '\t\t\t               [], ...\n');
    else 
      fprintf(fileOut, '\t\t\t               %g, ...\n', attr);
    end;      
    i = i + 1;
  end;
  fprintf(fileOut, '\t\t                };\n');
end;
fprintf(fileOut, '\tend;\n');
fprintf(fileOut, 'end;\n');

fclose(fileOut);


function value = getValue(field, name)

value = 'nnn';
switch (field)
  case 'typecode'
    value = getTypecode(name);
  case {'notes', ...
  'annotation', ...
  'formula', ...
  'variable', ...
  'species', ...
  'name', ...  
  'compartment', ...
  'id', ...
  'units', ...
  'metaid', ...
  'outside', ...
  'compartmentType', ...
  'speciesType', ...
  'conversionFactor', ...
  'spatialSizeUnits', ...
  'substanceUnits', ...
  'timeUnits', ...
  'lengthUnits', ...
  'areaUnits', ...
  'volumeUnits', ...
  'message', ...
  'math', ...
  'symbol', ...
  'value'}
    value = '';
  case 'type'
    value = 'scalar';
  case 'sboTerm'
    value = int32(-1);
  case 'volume'
    value = 1;
  case 'charge'
    value = 0;
  case {'size', ...
        'initialAmount', ...
        'initialConcentration'}
    value = NaN;
  case 'spatialDimensions'
    value = int32(3);
  case {'isSetVolume', ...
  'isSetSize', ...
  'isSetSpatialDimensions', ...
  'constant', ...
  'isSetValue', ...
  'boundaryCondition', ...
  'isSetBoundaryCondition', ...
  'hasOnlySubstanceUnits', ...
  'isSetInitialConcentration', ...
  'isSetInitialAmount', ...
  'isSetCharge', ...
  'persistent', ...
  'initialValue', ...
  'useValuesFromTriggerTime'}
    value = int32(0);
  case {'trigger', 'delay', 'priority', 'eventAssignment', 'product', ...
      'reactant', 'modifier', 'kineticLaw', 'unit', 'unitDefinition', ...
      'functionDefinition', 'parameter', 'localParameter', 'constraint', ...
      'rule', 'reaction', 'event'}
    value = [];
  otherwise
    value = sprintf('unrecognised %s', field);
end;


function typecode = getTypecode(name)

switch (name)
  case 'AlgebraicRule'
    typecode = 'SBML_ALGEBRAIC_RULE';
  case 'AssignmentRule'
    typecode = 'SBML_ASSIGNMENT_RULE';
  case 'Compartment'
    typecode = 'SBML_COMPARTMENT';
  case 'CompartmentType'
    typecode = 'SBML_COMPARTMENT_TYPE';
  case 'CompartmentVolumeRule'
    typecode = 'SBML_COMPARTMENT_VOLUME_RULE';
  case 'Constraint'
    typecode = 'SBML_CONSTRAINT';
  case 'Delay'
    typecode = 'SBML_DELAY';
  case 'Event'
    typecode = 'SBML_EVENT';
  case 'EventAssignment'
    typecode = 'SBML_EVENT_ASSIGNMENT';
  case 'FunctionDefinition'
    typecode = 'SBML_FUNCTION_DEFINITION';
  case 'InitialAssignment'
    typecode = 'SBML_INITIAL_ASSIGNMENT';
  case 'KineticLaw'
    typecode = 'SBML_KINETIC_LAW';
  case 'LocalParameter'
    typecode = 'SBML_LOCAL_PARAMETER';
  case 'ModifierSpeciesReference'
    typecode = 'SBML_MODIFIER_SPECIES_REFERENCE';
  case 'Parameter'
    typecode = 'SBML_PARAMETER';
  case 'ParameterRule'
    typecode = 'SBML_PARAMETER_RULE';
  case 'Priority'
    typecode = 'SBML_PRIORITY';
  case 'RateRule'
    typecode = 'SBML_RATE_RULE';
  case 'Reaction'
    typecode = 'SBML_REACTION';
  case 'Species'
    typecode = 'SBML_SPECIES';
  case 'SpeciesConcentrationRule'
    typecode = 'SBML_SPECIES_CONCENTRATION_RULE';
  case 'SpeciesReference'
    typecode = 'SBML_SPECIES_REFERENCE';
  case 'SpeciesType'
    typecode = 'SBML_SPECIES_TYPE';
  case 'StoichiometryMath'
    typecode = 'SBML_STOICHIOMETRY_MATH';
  case 'Trigger'
    typecode = 'SBML_TRIGGER';
  case 'Unit'
    typecode = 'SBML_UNIT';
  case 'UnitDefinition'
    typecode = 'SBML_UNIT_DEFINITION';
  case 'Model'
    typecode = 'SBML_MODEL';
  case 'Rule'
    typecode = 'SBML_RULE';
  otherwise
    error ('Unrecognised typecode');
 end;

function y = findText(line, textTofind)

y = 0;

ind = strfind(line, textTofind);
if length(ind) > 0
  y = 1;
end;
