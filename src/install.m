%  Filename: install.m
%
%  Description : File to install SBMLToolbox
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-10-01
%  Revision    : $Id$
%  Source      : $Source$
%
%  Copyright 2003 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%
%

clear;
clc;
% add the current directory and all subdirectories to the Matlab search
% path
ToolboxPath = genpath(pwd);
addpath(ToolboxPath);

% path2rc is deprecated by version 7.0.4 
% replaced by savepath
% but savepath doesnt exist in version 6.5.1 or lower

v = version;
v_num = str2num(v(1));

if (v_num < 7)
    s = path2rc;
else
    s = savepath;
end;

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
if (fail == 1)
  disp('Install successful');
else
  error('Installation was unsuccessful.');
end;

%prompt user for close

cAnswer = input('Do you want to close MATLAB (y/n)?', 's');
if (cAnswer == 'y')
    exit;
end;