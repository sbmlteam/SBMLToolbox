function createIsModelforBinding()

% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2016 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.

% check we are in the correct directory
% need to be in toolbox directory Validate_MATLAB_SBML_Structures
[root, this_dir] = fileparts(pwd());
if (~strcmp(this_dir, 'Validate_MATLAB_SBML_Structures'))
  error ('Need to be in the Validate_MATLAB_SBML_Structures directory');
end;
spacer = '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';

% get original isModel_SBML.m

fileOut = fopen('isValidSBML_Model.m', 'r');

fileIn = fopen('bind_isSBML_Model.m', 'w');

while (~feof(fileOut))
  line = fgetl(fileOut);
  fprintf(fileIn, '%s\n', line);
end;

fprintf(fileIn, '\n%s\n\n', spacer);

% get other files
files = dir('isSBML_*.m');

for i = 1:length(files)
  if (~strcmp(files(i).name, 'isSBML_Model.m'))
    copyFile(files(i).name, fileIn, 0);
    fprintf(fileIn, '\n%s\n\n', spacer);
  end;
end;

% get valid level and version
fileLV = '../MATLAB_SBML_Structure_Functions/structFieldnames/isValidlevelVersionCombination.m';
copyFile(fileLV, fileIn, 0);
  fprintf(fileIn, '\n%s\n\n', spacer);

fileInt = '../Convenience/isIntegralNumber.m';
copyFile(fileInt, fileIn, 0);
  fprintf(fileIn, '\n%s\n\n', spacer);

files = dir('../MATLAB_SBML_Structure_Functions/structFieldnames/*Fieldnames.m');

for i = 1:length(files)
  file1 = strcat('../MATLAB_SBML_Structure_Functions/structFieldnames/', files(i).name);
  copyFile(file1, fileIn, 1);
  fprintf(fileIn, '\n%s\n\n', spacer);
end;

fclose(fileOut);
fclose(fileIn);

function copyFile(filename, fileIn, a)

fileOut1 = fopen(filename, 'r');

%copy first line
line = fgetl(fileOut1);
fprintf(fileIn, '%s\n', line);
if a == 1
  line = fgetl(fileOut1);
  fprintf(fileIn, '%s\n', line);
end;
end_of_comment = 0;

while (~end_of_comment)
  line = fgetl(fileOut1);
  if (length(line) > 10)
    begins = line(1:10);
    if (strcmp(begins, '%---------'))
      end_of_comment = 1;
    end;
  end;
end;

while (~feof(fileOut1))
  line = fgetl(fileOut1);
  fprintf(fileIn, '%s\n', line);
end;

fclose(fileOut1);
