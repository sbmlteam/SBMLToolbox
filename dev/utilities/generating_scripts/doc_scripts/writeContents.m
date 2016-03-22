function writeContents()
% writes a Contents.m file for matlab help
% and a contents.txt file for generating html from

fileOut = fopen('Contents.m', 'w');
fileTxt = fopen('contents.txt', 'w');

% work out the subdirectory name and output at the top of the file
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
fprintf(fileTxt, '###%s\n\n\nwriteInfo here\n\n', upper(out));
fprintf(fileTxt, 'Function are:\n\n----------\n\n');
out = sprintf('%s\\%s', 'toolbox', out);


fprintf(fileOut, '%% %s\n%%\n%% Info here. \n%%\n', out);

listfiles = dir(pwd);

% for each code file in the directory
for i=1:length(listfiles)
  if (listfiles(i).isdir ~= 1 && ~strcmp(listfiles(i).name, 'Contents.m') ...
      && ~strcmp(listfiles(i).name, 'contents.txt'))
    fIn = fopen(listfiles(i).name, 'r');
    disp(sprintf('Processing %s', listfiles(i).name));
    
    % get first two lines -check for function definition that
    % spans two lines and ignore the function definition line(s)
    
    line2 = fgetl(fIn);
    line = fgetl(fIn);
    if strfind(line2, '...')
      line = fgetl(fIn);
    end;
    
    % in Contents.m write 
    % ====================
    % function declaration
    % ====================
    
    
    fprintf(fileOut, '%%');
    for j=1:length(line)
      fprintf(fileOut, '=');
    end;
    fprintf(fileOut, '\n%s\n%%', line);
    for j=1:length(line)
      fprintf(fileOut, '=');
    end;
    fprintf(fileOut, '\n');
    
    % in contents.txt write
    % ###function declaration (h2 in markdown)
    
    fprintf(fileTxt, '####%s\n', line(3:end));
    
    % loop thru the help lines in the code file
    % these end at the first blank line
    
    %in Contents.m write
    % the help with no blank lines between text
    % leave out any notes or examples
    % put blank line between functions
    
    % in contents.txt write 
    % the help as is but removing leading %
    % put a line between functions
    % NOTE: the help in the function files is formatted to facilitate markdown
    
    line = fgetl(fIn);
    ex = 0;
    note = 0;
    while ~isempty(line)
      short = 0;
      if length(line) < 3
        short = 1;
      elseif length(line) > 11 && strcmp(line(1:12), '% *EXAMPLE:*')
        ex = 1;
      elseif length(line) > 8 && strcmp(line(1:9), '% *NOTE:*')
        note = 1;
      end;
      if (ex == 0 && note == 0 && short == 0)
        fprintf(fileOut, '%s\n', line);
      end;
      fprintf(fileTxt, '%s\n', line(3:end));     
      line = fgetl(fIn);
    end;
    fclose(fIn);
    fprintf(fileOut, '%%\n');
    fprintf(fileTxt, '\n\n------------------------------\n\n');
  end;
end;

% put licence into the Contents.m file as it is released

% put in header and licence
fprintf(fileOut, '\n\n%%<!---------------------------------------------------------------------------\n');
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


fclose(fileOut);
fclose(fileTxt);
