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
try
     M = TranslateSBML('test.xml');
catch
    % determine the matlabroot for windows executable
    % this directory is saved to the environmental variable PATH
    Path_to_libs = matlabroot;
    Path_to_libs = strcat(Path_to_libs, '\bin\win32');

    % determine the location of the library files
    if (exist('..\extern') == 7)
        lib{1} = '..\extern\bin\libsbml.lib';
        lib{2} = '..\extern\bin\xerces-c_2.lib';
        lib{3} = '..\extern\bin\libsbml.dll';
        lib{4} = '..\extern\bin\xerces-c_2_5_0.dll';
        lib{5} = '..\extern\bin\libsbmlD.lib';
        lib{6} = '..\extern\bin\xerces-c_2D.lib';
        lib{7} = '..\extern\bin\libsbmlD.dll';
        lib{8} = '..\extern\bin\xerces-c_2_5_0D.dll';
    else
        lib{1} = '..\win32\bin\libsbml.lib';
        lib{2} = '..\win32\bin\xerces-c_2.lib';
        lib{3} = '..\win32\bin\libsbml.dll';
        lib{4} = '..\win32\bin\xerces-c_2_5_0.dll';
        lib{5} = '..\win32\bin\libsbmlD.lib';
        lib{6} = '..\win32\bin\xerces-c_2D.lib';
        lib{7} = '..\win32\bin\libsbmlD.dll';
        lib{8} = '..\win32\bin\xerces-c_2_5_0D.dll';
    end;

    for i = 1:8
       copyfile(lib{i}, Path_to_libs);
    end;
end;

if (isempty(M))
    M = TranslateSBML('test.xml');
end;

if (isSBML_Model(M))
    disp('Install successful');
else
    error('Installation was unsuccessful.');
end;

%prompt user for close

cAnswer = input('Do you want to close MATLAB (y/n)?', 's');
if (cAnswer == 'y')
    exit;
end;