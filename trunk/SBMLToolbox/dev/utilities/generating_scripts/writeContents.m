function writeContents

% Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
%    'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
%     'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
%      'Model', 'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
%       'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
%        'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
%         'Unit', 'UnitDefinition'};
% 
% for i=1:length(Objects)
%   cd (Objects{i});
%   writeStruct(Objects{i});
%   cd ..
% end;

filename = sprintf('Contents.m');
fileOut = fopen(filename, 'w');

src = 'src';
out = '';
[top, a] = fileparts(pwd);
while(~strcmp(a, src))
  if isempty(out)
    out = sprintf('%s', a);
  else
    out = sprintf('%s\\%s', a, out);
  end;
  [top, a] = fileparts(top);
end;
out = sprintf('%s\\%s', 'toolbox', out);


fprintf(fileOut, '%% %s\n%%\n', out);

listfiles = dir(pwd);

for i=1:length(listfiles)
  if (listfiles(i).isdir ~= 1 && ~strcmp(listfiles(i).name, 'Contents.m'))
%    fprintf(fileOut, '%% %s\n', listfiles(i).name);
    fIn = fopen(listfiles(i).name, 'r');
    %% get first two line
    fgetl(fIn);
    line = fgetl(fIn);
    while ~isempty(line)
      fprintf(fileOut, '%s\n', line);
      line = fgetl(fIn);
    end;
    fclose(fIn);
    fprintf(fileOut, '%%\n');
  end;
end;

% put in header and licence
fprintf(fileOut, '\n\n%%  Filename    :   Contents.m\n');
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

fclose(fileOut);