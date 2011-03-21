%  Filename: install.m
%

%  Description : File to install SBMLToolbox
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%
%  $Id$
%  $Source$
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
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
%----------------------------------------------------------------------- -->

clear;
clc;
% add the current directory and all subdirectories to the MATLAB search
% path
ToolboxPath = genpath(pwd);
addpath(ToolboxPath);

s = savepath;

if (s ~= 0)
    error('Directory NOT added to the path');
end;

% try the executable
% if it doesnt work the library files are not on the system path and need
% to be placed there
M = struct([]);
fail = 1;
try
     M = TranslateSBML('test.xml');
catch
  % BINDING NOT INSTALLED
  disp('Binding not installed.');
  disp('SBMLToolbox requires that the MATLAB binding of libSBML is installed.');
  return;
end;

if (isempty(M))
  error('Unknown error encountered');
else
  disp('libSBML MATLAB binding detected');
end;

try
  OutputSBML(M, 'test_out.xml');
catch
  disp('The OutputSBML executable cannot be found.');
  disp('Please build it as appropriate for your system.');
  return;
end;

fail = CompareFiles('test.xml', 'test_out.xml');
if (fail == 0)
  disp('Install successful');
else
  error('Installation was unsuccessful.');
end;

%prompt user for close

cAnswer = input('Do you want to close MATLAB (y/n)?', 's');
if (cAnswer == 'y')
    exit;
end;
