function SaveSBMLModel(SBMLModel)
% SaveSBML(SBMLModel) saves the SBMLModel structure to the disk
%
% Checks that SBMLModel is an sbml model structure
% checks whether the SBML_Models.mat file exists and creates if necessary
% adds the SBMLModel to the file as the next structure
% saves the SBML_Models.mat file

%
%  Filename    : SaveSBMLModel.m
%  Description : saves a model to data file SBML_Models
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

bSBML = 0;
bSBML = isSBML_Model(SBMLModel);

% find the only copy of SBML_Models.mat
Path = which ('SBML_Models.mat');

if (bSBML == 1)
    % check whether file exists
    fId = fopen(Path);
    
    % if not create file and path and index from zero
    if (fId == -1)
        fId = fopen('SBML_Models.mat', 'w');
        Current = pwd;
        Path = strcat(Current, '\SBML_Models.mat');
        n_level1 = 0;
        n_level2 = 0;
        n_level2v2 = 0;
        n_level2v3 = 0;
    else
    % load existing models and determine number for each level of sbml
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
        end;    end;
    
    fclose(fId);
    
    % check whether model with the same name already exists
    NewIndex = 0;
    if (SBMLModel.SBML_level == 1)
        for index = 1:n_level1
            k = strcmp(Models_l1(index).name, SBMLModel.name);
            if (k ==1)
                Answer = AlreadyExists;  %error('Model with this name already exists');
                if (strcmp(Answer, 'No'))
                    return;
                else
                    NewIndex = index;
                end;
            end;
        end;
    else
        if (SBMLModel.SBML_version == 1)
            for index = 1:n_level2
                k = strcmp(Models_l2(index).name, SBMLModel.name);
                l = strcmp(Models_l2(index).id, SBMLModel.id);
                if (k ==1 && l ==1)
                    Answer = AlreadyExists;  %error('Model with this name and id already exists');
                    if (strcmp(Answer, 'No'))
                        return;
                    else
                        NewIndex = index;
                    end;
                end;
            end;
        elseif (SBMLModel.SBML_version == 2)
            for index = 1:n_level2v2
                k = strcmp(Models_l2v2(index).name, SBMLModel.name);
                l = strcmp(Models_l2v2(index).id, SBMLModel.id);
                if (k ==1 && l ==1)
                    Answer = AlreadyExists;  %error('Model with this name and id already exists');
                    if (strcmp(Answer, 'No'))
                        return;
                    else
                        NewIndex = index;
                    end;
                end;
            end;
        elseif (SBMLModel.SBML_version == 3)
            for index = 1:n_level2v3
                k = strcmp(Models_l2v3(index).name, SBMLModel.name);
                l = strcmp(Models_l2v3(index).id, SBMLModel.id);
                if (k ==1 && l ==1)
                    Answer = AlreadyExists;  %error('Model with this name and id already exists');
                    if (strcmp(Answer, 'No'))
                        return;
                    else
                        NewIndex = index;
                    end;
                end;
            end;
        end;
    end;

    % add SBMLModel as the next structure and save
    if (SBMLModel.SBML_level == 1)
        if (NewIndex == 0)
            NewIndex = n_level1+1;
            n_level1 = NewIndex;
        end;
        Models_l1(NewIndex) = SBMLModel;
    else
        if (SBMLModel.SBML_version == 1)
            if (NewIndex == 0)
                NewIndex = n_level2+1;
                n_level2 = NewIndex;
            end;
            Models_l2(NewIndex) = SBMLModel;
        elseif (SBMLModel.SBML_version == 2)
            if (NewIndex == 0)
                NewIndex = n_level2v2+1;
                n_level2v2 = NewIndex;
            end;
            Models_l2v2(NewIndex) = SBMLModel;
        elseif (SBMLModel.SBML_version == 3)
            if (NewIndex == 0)
                NewIndex = n_level2v3+1;
                n_level2v3 = NewIndex;
            end;
            Models_l2v3(NewIndex) = SBMLModel;
        end;
    end;
    
    
    % save appropriate structures
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

        
            
    
else
    error('Structure supplied is not an sbml model');
end;

clear


