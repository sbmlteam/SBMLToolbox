function writeTemp(name)

newfilename = sprintf('get%sFieldnames.m', name);
fileIn = fopen('template.m', 'r');
fileOut = fopen(newfilename', 'w');

fprintf(fileOut, 'function [SBMLfieldnames, nNumberFields] = get%sFieldnames(level, ...\n', name);
for i=1:57+length(name)
  fprintf(fileOut, ' ');
end;
fprintf(fileOut, 'version)\n\n');
% puit in header and licence
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%% get%sFieldnames\n', name); 
fprintf(fileOut, '%%    takes an SBML level\n'); 
fprintf(fileOut, '%%     and  an SBML version\n');
fprintf(fileOut, '%%\n');
fprintf(fileOut, '%%    returns\n'); 
fprintf(fileOut, '%%      1) an array fieldnames for the %s structure of the appropriate\n', name);
fprintf(fileOut, '%%                  level and version\n');
fprintf(fileOut, '%%      2) the number of fieldnames expected\n\n');

fprintf(fileOut, '%%  Filename    :   get%sFieldnames.m\n', name);
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

splitLine = 0;
while ~feof(fileIn)
  line = fgetl(fileIn);
  if (findText(line, 'if (Level == 1'))
    fprintf(fileOut, 'if (level == 1)\n');
    nextLine = fgetl(fileIn);
    if (findText(nextLine, 'y = 0'))
      fprintf(fileOut, '\tSBMLfieldnames = [];\n\tnNumberFields = 0;\n');
    else
      fprintf(fileOut, '\t\tSBMLfieldnames = {');
      while (~findText(nextLine, 'nNumber'))
        commas = strfind(nextLine, '''');
        attr = nextLine(commas(1):commas(2));
        if (splitLine == 0)
          fprintf(fileOut, ' %s, ...\n', attr);
        else
          fprintf(fileOut, '\t\t                   %s, ...\n', attr);
        end;
        for i = 3:2:length(commas)
          attr = nextLine(commas(i):commas(i+1));
          fprintf(fileOut, '\t\t                   %s, ...\n', attr);
        end;
        nextLine = fgetl(fileIn);
        splitLine = splitLine + 1;
      end;
      splitLine = 0;
      fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine));
    end;
  elseif (findText(line, 'Level == 2'))
    fprintf(fileOut, 'elseif (level == 2)\n');
    nextLine = fgetl(fileIn);
    count = 0;
    while (~findText(nextLine, 'end;') && count < 30)
      if (findText(nextLine, 'Version == 1'))
        fprintf(fileOut, '\tif (version == 1)\n');
        nextLine1 = fgetl(fileIn);
        if (findText(nextLine1, 'y = 0'))
          fprintf(fileOut, '\t\tSBMLfieldnames = [];\n\t\tnNumberFields = 0;\n');
        else
          fprintf(fileOut, '\t\tSBMLfieldnames = {');
          while (~findText(nextLine1, 'nNumber'))
            commas = strfind(nextLine1, '''');
            attr = nextLine1(commas(1):commas(2));
            if (splitLine == 0)
              fprintf(fileOut, ' %s, ...\n', attr);
            else
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            for i = 3:2:length(commas)
              attr = nextLine1(commas(i):commas(i+1));
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            nextLine1 = fgetl(fileIn);
            splitLine = splitLine + 1;
          end;
          splitLine = 0;
          fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine1));
        end;
      elseif (findText(nextLine, 'Version == 2'))
        fprintf(fileOut, '\telseif (version == 2)\n');
        nextLine1 = fgetl(fileIn);
        if (findText(nextLine1, 'y = 0'))
          fprintf(fileOut, '\t\tSBMLfieldnames = [];\n\t\tnNumberFields = 0;\n');
        else
          fprintf(fileOut, '\t\tSBMLfieldnames = {');
          while (~findText(nextLine1, 'nNumber'))
            commas = strfind(nextLine1, '''');
            attr = nextLine1(commas(1):commas(2));
            if (splitLine == 0)
              fprintf(fileOut, ' %s, ...\n', attr);
            else
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            for i = 3:2:length(commas)
              attr = nextLine1(commas(i):commas(i+1));
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            nextLine1 = fgetl(fileIn);
            splitLine = splitLine + 1;
          end;
          splitLine = 0;
          fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine1));
        end;
      elseif (findText(nextLine, 'Version == 3'))
        fprintf(fileOut, '\telseif (version == 3)\n');
        nextLine1 = fgetl(fileIn);
        if (findText(nextLine1, 'y = 0'))
          fprintf(fileOut, '\t\tSBMLfieldnames = [];\n\t\tnNumberFields = 0;\n');
        else
          fprintf(fileOut, '\t\tSBMLfieldnames = {');
          while (~findText(nextLine1, 'nNumber'))
            commas = strfind(nextLine1, '''');
            attr = nextLine1(commas(1):commas(2));
            if (splitLine == 0)
              fprintf(fileOut, ' %s, ...\n', attr);
            else
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            for i = 3:2:length(commas)
              attr = nextLine1(commas(i):commas(i+1));
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            nextLine1 = fgetl(fileIn);
            splitLine = splitLine + 1;
          end;
          splitLine = 0;
          fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine1));
        end;
      elseif (findText(nextLine, 'Version == 4'))
        fprintf(fileOut, '\telseif (version == 4)\n');      
        nextLine1 = fgetl(fileIn);
        if (findText(nextLine1, 'y = 0'))
          fprintf(fileOut, '\t\tSBMLfieldnames = [];\n\t\tnNumberFields = 0;\n');
        else
          fprintf(fileOut, '\t\tSBMLfieldnames = {');
          while (~findText(nextLine1, 'nNumber'))
            commas = strfind(nextLine1, '''');
            attr = nextLine1(commas(1):commas(2));
            if (splitLine == 0)
              fprintf(fileOut, ' %s, ...\n', attr);
            else
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            for i = 3:2:length(commas)
              attr = nextLine1(commas(i):commas(i+1));
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            nextLine1 = fgetl(fileIn);
            splitLine = splitLine + 1;
          end;
          splitLine = 0;
          fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine1));
        end;
      end;
      nextLine = fgetl(fileIn);
    end;
  elseif (findText(line, 'Level == 3'))
    fprintf(fileOut, '\tend;\nelseif (level == 3)\n');
    nextLine = fgetl(fileIn);
    if (findText(nextLine, 'Version == 1'))
      fprintf(fileOut, '\tif (version == 1)\n');
      nextLine1 = fgetl(fileIn);
      if (findText(nextLine1, 'y = 0'))
        fprintf(fileOut, '\t\tSBMLfieldnames = [];\n\t\tnNumberFields = 0;\n');
      else
        fprintf(fileOut, '\t\tSBMLfieldnames = {');
        while (~findText(nextLine1, 'nNumber'))
          commas = strfind(nextLine1, '''');
          attr = nextLine1(commas(1):commas(2));
            if (splitLine == 0)
              fprintf(fileOut, ' %s, ...\n', attr);
            else
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            for i = 3:2:length(commas)
              attr = nextLine1(commas(i):commas(i+1));
              fprintf(fileOut, '\t\t                   %s, ...\n', attr);
            end;
            nextLine1 = fgetl(fileIn);
            splitLine = splitLine + 1;
          end;
          splitLine = 0;
          fprintf(fileOut, '\t\t                 };\n\t\t%s\n', strtrim(nextLine1));
      end;
      fprintf(fileOut, '\tend;\nend;\n');
    end;
  end;
end;




fclose(fileIn);
fclose(fileOut);

function y = findText(line, textTofind)

y = 0;

ind = strfind(line, textTofind);
if length(ind) > 0
  y = 1;
end;
