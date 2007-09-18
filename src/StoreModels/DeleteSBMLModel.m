function Model = DeleteSBMLModel(varargin)
% DeleteSBMLModel(input, level, version(optional)) deletes a sbml model of specified level from SBML_Models.mat
% If version is not specified it defaults to 1
%
% input can be either
% an integer representing the index of the model in
% the data file e.g. Models(int)
%
% or it can be the name or id (level 2) of the model
%
% if two or more models in the data file have the same name 
% (which shouldnt happen as this should be caught when saving)
% DeleteSBMLModel will delete the first model it matches

%
%  Filename    : DeleteSBMLModel.m
%  Description : deletes a model from data file SBML_Models
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

if (nargin < 2 || nargin > 3)
    error('USAGE: DeleteSBMLModel(x, level, version(optional)) where x is the number or the name of the model');
else
    input = varargin{1};
    Level = varargin{2};
end;

if (nargin == 3)
    Version = varargin{3};
else
    if (Level == 1)
        Version = 2;
    else
        Version = 1;
    end;
end;

bInt = 0;
% check what type of arguments have been input
if (isnumeric(input))
    nNumber = input;
    bInt = 1;
    if (nNumber <= 0)
        error('Number input must be greater than 0');
    end;
elseif (ischar(input))
    Name = input;
    if (Level == 2)
        Id = input;
    end;
else
    error('USAGE: DeleteSBMLModel(x, level, version(optional)) where x is the number or the name of the model');
end;

% find the only copy of SBML_Models.mat
Path = which ('SBML_Models.mat');

% check whether file exists
fId = fopen(Path);
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

if (Level == 1)
    n = n_level1;
else
    if (Version == 1)
        n = n_level2;
    elseif (Version == 2)
        n = n_level2v2;
    else
        n = n_level2v3;
    end;
end;

if (bInt == 1) 
% input was the number of the model
    if (nNumber > n)
        error('Index exceeds number stored models');
    end;
else
% input is the name of a model
    nNumber = 1;
    while (nNumber <= n)
        if (Level == 1)
            % find the index of the model with the input name
            k = strcmp(Models_l1(nNumber).Name, Name);
            if (k == 1)
                break;
            else
                nNumber = nNumber + 1;
            end;
        elseif (Level == 2 && Version == 1)
            k = strcmp(Models_l2(nNumber).Name, Name);
            l = strcmp(Models_l2(nNumber).Id, Id);
            if (k == 1)
                break;
            elseif (l == 1)
                break;
            else
                nNumber = nNumber + 1;
            end;
        elseif (Level == 2 && Version == 2)
            k = strcmp(Models_l2v2(nNumber).Name, Name);
            l = strcmp(Models_l2v2(nNumber).Id, Id);
            if (k == 1)
                break;
            elseif (l == 1)
                break;
            else
                nNumber = nNumber + 1;
            end;
        elseif (Level == 2 && Version == 3)
            k = strcmp(Models_l2v3(nNumber).Name, Name);
            l = strcmp(Models_l2v3(nNumber).Id, Id);
            if (k == 1)
                break;
            elseif (l == 1)
                break;
            else
                nNumber = nNumber + 1;
            end;
        end;
    end;
    
    % check that a match has been made
    if (Level == 1 && nNumber == n+1 && k ~= 1) 
        error('No model saved with matching name');
    elseif (Level == 2 && Version == 1 && nNumber == n_level2+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    elseif (Level == 2 && Version == 2 && nNumber == n_level2v2+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    elseif (Level == 2 && Version == 3 && nNumber == n_level2v3+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    end;
end;

% delete model with index nNumber
% by resaving remainder of models to new indices
if (Level == 1)
    for i = 1:nNumber-1
        TempModels(i) = Models_l1(i);
    end;
    for i = nNumber:n-1
        TempModels(i) = Models_l1(i + 1);
    end;
    clear Models_l1;
    for i = 1:n-1
        Models_l1(i) = TempModels(i);
    end;
    n_level1 = n-1;
else
    if (Version == 1)
        for i = 1:nNumber-1
            TempModels(i) = Models_l2(i);
        end;
        for i = nNumber:n-1
            TempModels(i) = Models_l2(i + 1);
        end;
        clear Models_l2;
        for i = 1:n-1
            Models_l2(i) = TempModels(i);
        end;
        n_level2 = n-1;
    elseif (Version == 2)
        for i = 1:nNumber-1
            TempModels(i) = Models_l2v2(i);
        end;
        for i = nNumber:n-1
            TempModels(i) = Models_l2v2(i + 1);
        end;
        clear Models_l2v2;
        for i = 1:n-1
            Models_l2v2(i) = TempModels(i);
        end;
        n_level2v2 = n-1;
    elseif (Version == 3)
        for i = 1:nNumber-1
            TempModels(i) = Models_l2v3(i);
        end;
        for i = nNumber:n-1
            TempModels(i) = Models_l2v3(i + 1);
        end;
        clear Models_l2v3;
        for i = 1:n-1
            Models_l2v3(i) = TempModels(i);
        end;
        n_level2v3 = n-1;
    end;
end;

% delete old file and save new list of models
% save each strcuture

index = 1;
Nums = [n_level1, n_level2, n_level2v2, n_level2v3];
Present = find(Nums ~= 0);

for i = 1:length(Present)
    switch (Present(i))
        case 1 
            output{index} = 'Models_l1';
        case 2
            output{index} = 'Models_l2';
        case 3
            output{index} = 'Models_l2v2';
        case 4
            output{index} = 'Models_l2v3';
    end;
    index = index + 1;
end;
n = length(output);
switch (n)
    case 1
        save (Path, output{1});
    case 2
        save (Path, output{1}, output{2});
    case 3
        save (Path, output{1}, output{2}, output{3});
    case 4
        save (Path, output{1}, output{2}, output{3}, output{4});
end;

