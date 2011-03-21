function Model = LoadSBMLModel(varargin)
% LoadSBMLModel(input, level, version(optional)) returns a sbml model of specified level from SBML_Models.mat
% If version is not specified it defaults to 1
%
% input can be either
% an integer representing the index of the model in
% the data file e.g. Models(int)
%
% or it can be the name (or id for level 2)of the model
%
% if two or more models in the data file have the same name 
% LoadSBMLModel will return the first model it matches
%
% the function also checks that the structure returned is a valid sbml
% model structure

%  Filename    :   LoadSBMLModel.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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


if (nargin < 2 || nargin > 3)
    error('USAGE: LoadSBMLModel(x, level, version(optional)) where x is the number or the name of the model');
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
    error('USAGE: LoadSBMLModel(x, level, version(optional)) where x is the number or the name of the model');
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

if (~exist('Models_l2v4'))
    n_level2v4 = 0;
else
    [m, n_level2v4] = size(Models_l2v4);
end;


if (Level == 1)
    n = n_level1;
else
    if (Version == 1)
        n = n_level2;
    elseif (Version == 2)
        n = n_level2v2;
    elseif (Version == 3)
        n = n_level2v3;
    else
        n = n_level2v4;
    end;
end;

if (bInt == 1) 
% input was the number of the model
    if (nNumber > n)
        error('Index exceeds number stored models');
    else
        if (Level == 1)
            Model = Models_l1(nNumber);
        else
            if (Version == 1)
                Model = Models_l2(nNumber);
            elseif (Version == 2)
                Model = Models_l2v2(nNumber);
            elseif (Version == 3)
                Model = Models_l2v3(nNumber);
            elseif (Version == 4)
                Model = Models_l2v4(nNumber);
            end;
        end;
        
        if(isSBML_Model(Model) == 0)
            error('Structure read from file is not a valid sbml model');
        end;
    end;
else
% input is the name of a model
    nNumber = 1;
    if (Level == 1)
        while (nNumber <= n_level1)
            % find the index of the model with the input name
            k = strcmp(Models_l1(nNumber).name, Name);
            if (k == 1)
                Model = Models_l1(nNumber);
                break;
            else
                nNumber = nNumber + 1;
            end;
        end;
    else
        if (Version == 1)
            while (nNumber <= n_level2)
                k = strcmp(Models_l2(nNumber).name, Name);
                l = strcmp(Models_l2(nNumber).id, Id);
                if (k == 1)
                    Model = Models_l2(nNumber);
                    break;
                elseif (l == 1)
                    Model = Models_l2(nNumber);
                    break;
                else
                    nNumber = nNumber + 1;
                end;
            end;
        elseif (Version == 2)
            while (nNumber <= n_level2v2)
                k = strcmp(Models_l2v2(nNumber).name, Name);
                l = strcmp(Models_l2v2(nNumber).id, Id);
                if (k == 1)
                    Model = Models_l2v2(nNumber);
                    break;
                elseif (l == 1)
                    Model = Models_l2v2(nNumber);
                    break;
                else
                    nNumber = nNumber + 1;
                end;
            end;
        elseif (Version == 3)
            while (nNumber <= n_level2v3)
                k = strcmp(Models_l2v3(nNumber).name, Name);
                l = strcmp(Models_l2v3(nNumber).id, Id);
                if (k == 1)
                    Model = Models_l2v3(nNumber);
                    break;
                elseif (l == 1)
                    Model = Models_l2v3(nNumber);
                    break;
                else
                    nNumber = nNumber + 1;
                end;
            end;
        elseif (Version == 4)
            while (nNumber <= n_level2v4)
                k = strcmp(Models_l2v4(nNumber).name, Name);
                l = strcmp(Models_l2v4(nNumber).id, Id);
                if (k == 1)
                    Model = Models_l2v4(nNumber);
                    break;
                elseif (l == 1)
                    Model = Models_l2v4(nNumber);
                    break;
                else
                    nNumber = nNumber + 1;
                end;
            end;
        end;
    end;
           
    % check that a match has been made
    if (Level == 1 && nNumber == n_level1+1 && k ~=1)
        error('No model saved with matching name');
    elseif (Level == 2 && Version == 1 && nNumber == n_level2+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    elseif (Level == 2 && Version == 2 && nNumber == n_level2v2+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    elseif (Level == 2 && Version == 3 && nNumber == n_level2v3+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
    elseif (Level == 2 && Version == 4 && nNumber == n_level2v4+1 && k ~= 1 && l ~=1)
        error('No model saved with matching name or id');
   end;
    
    % check that model returned is an sbml model
    if (~isSBML_Model(Model))
        error('Structure read from file is not a valid sbml model');
    end;
end;
