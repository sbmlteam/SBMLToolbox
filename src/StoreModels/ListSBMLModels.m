function ListSBMLModels
% ListSBMLModels lists the sbml models saved in SBML_Models.mat
% returns the Number, Level, Version and Name of the model

%  Filename    :   ListSBMLModels.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->


% check whether file exists
fId = fopen('SBML_Models.mat');
if (fId == -1)
    error('SBML_Models.mat not found');
else
    fclose(fId);
end;

% read in the file
load 'SBML_Models';
if (~exist('Models_l1'))
    n_level1 = 0;
else
    [m, n_level1] = size(Models_l1);
end;

if (~exist('Models_l2'))
    n_level2 = 0;
else
    [m, n_level2] = size(Models_l2);
end;

if (~exist('Models_l2v2'))
    n_level2v2 = 0;
else
    [m, n_level2v2] = size(Models_l2v2);
end;

if (~exist('Models_l2v3'))
    n_level2v3 = 0;
else
    [m, n_level2v3] = size(Models_l2v3);
end;

if (~exist('Models_l2v4'))
    n_level2v4 = 0;
else
    [m, n_level2v4] = size(Models_l2v4);
end;

j = 'NUMBER  LEVEL   VERSION   NAME';
disp(j)
for nNumber = 1:n_level1
    name = Models_l1(nNumber).name;
    i = int2str(nNumber);
    f = int2str(1);
    g = int2str(Models_l1(nNumber).SBML_version);
    j = fprintf(1,'  %s       %s        %s      %s\n', i, f, g, name);
end;

for nNumber =1:n_level2
    name = Models_l2(nNumber).id;
    k = isempty(name);
    if (k == 1)
        name = Models_l2(nNumber).name;
    end;
    i = int2str(nNumber);
    f = int2str(2);
    g = int2str(Models_l2(nNumber).SBML_version);
    j = fprintf(1,'  %s       %s        %s      %s\n', i, f, g, name);
end;
  
for nNumber =1:n_level2v2
    name = Models_l2v2(nNumber).id;
    k = isempty(name);
    if (k == 1)
        name = Models_l2v2(nNumber).name;
    end;
    i = int2str(nNumber);
    f = int2str(2);
    g = int2str(Models_l2v2(nNumber).SBML_version);
    j = fprintf(1,'  %s       %s        %s      %s\n', i, f, g, name);
end;

for nNumber =1:n_level2v3
    name = Models_l2v3(nNumber).id;
    k = isempty(name);
    if (k == 1)
        name = Models_l2v3(nNumber).name;
    end;
    i = int2str(nNumber);
    f = int2str(2);
    g = int2str(Models_l2v3(nNumber).SBML_version);
    j = fprintf(1,'  %s       %s        %s      %s\n', i, f, g, name);
end;

for nNumber =1:n_level2v4
    name = Models_l2v4(nNumber).id;
    k = isempty(name);
    if (k == 1)
        name = Models_l2v4(nNumber).name;
    end;
    i = int2str(nNumber);
    f = int2str(2);
    g = int2str(Models_l2v4(nNumber).SBML_version);
    j = fprintf(1,'  %s       %s        %s      %s\n', i, f, g, name);
end;
