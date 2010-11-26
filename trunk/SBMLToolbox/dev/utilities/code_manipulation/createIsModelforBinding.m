function createIsModelforBinding()

% check we are in the correct directory
% need to be in toolbox directory Validate_MATLAB_SBML_Structures
[root, this_dir] = fileparts(pwd());
if (~strcmp(this_dir, 'Validate_MATLAB_SBML_Structures'))
  error ('Need to be in the Validate_MATLAB_SBML_Structures directory');
end;
spacer = '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';

% get original isModel_SBML.m

fileOut = fopen('isSBML_Model.m', 'r');

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
    copyFile(files(i).name, fileIn);
    fprintf(fileIn, '\n%s\n\n', spacer);
  end;
end;

fclose(fileOut);
fclose(fileIn);

function copyFile(filename, fileIn)

fileOut1 = fopen(filename, 'r');

%copy first line
line = fgetl(fileOut1);
fprintf(fileIn, '%s\n', line);

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