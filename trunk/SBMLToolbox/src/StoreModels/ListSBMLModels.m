function ListSBMLModels
%
%  Filename    : ListSBMLModels.m
%  Description : lists the models in data file SBML_Models
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-09-15
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
% ListSBMLModels lists the sbml models saved in SBML_Models.mat
% returns the Number and Name of the model

% check whether file exists
fId = fopen('SBML_Models.mat');
if (fId == -1)
    error('SBML_Models.mat not found');
else
    fclose(fId);
end;

% read in the file
load 'SBML_Models';
if (exist('Models_l1') == 0) 
    [m, n_level2] = size(Models_l2);
    n_level1 = 0;
elseif (exist('Models_l2') == 0)
    [m, n_level1] = size(Models_l1);
    n_level2 = 0;               
else
    [m, n_level1] = size(Models_l1);
    [m, n_level2] = size(Models_l2);
end;

j = 'NUMBER  LEVEL   NAME';
disp(j)
for nNumber = 1:n_level1
    name = Models_l1(nNumber).name;
    i = int2str(nNumber);
    f = int2str(1);
    j = fprintf(1,'  %s       %s     %s\n', i, f,name);
end;

for nNumber =1:n_level2
    name = Models_l2(nNumber).id;
    k = isempty(name);
    if (k == 1)
        name = Models_l2(nNumber).name;
    end;
    i = int2str(nNumber);
    f = int2str(2);
    j = fprintf(1,'  %s       %s     %s\n', i, f,name);
end;
  

