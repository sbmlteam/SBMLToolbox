function varargout = GetSpecies(SBMLModel)
% GetSpecies takes a SBMLModel 
% and returns 
%           1) an array of character names of all species within the model 
%           2) an array of the initial concentration/amount values of each species
%
% NOTE: if the initial concentration/amount are not set then the value NaN is used

%--------------------------------------------------------------------------
%
%  Filename    : GetSpecies.m
%  Description : takes a SBMLModel and returns an array of character names representing all species 
%                   and an array of the initial values of each species
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetSpecies(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of species within the model
NumSpecies = length(SBMLModel.species);

%------------------------------------------------------------
% loop through the list of species
for i = 1:NumSpecies

    %determine the name or id of the species
    if (SBMLModel.SBML_level == 1)
        name = SBMLModel.species(i).name;
    else
        if (isempty(SBMLModel.species(i).id))
            name = SBMLModel.species(i).name;
        else
            name = SBMLModel.species(i).id;
        end;
    end;

    % and array of the character names
    CharArray{i} = name;

    % get the initial concentration values
    % add to an array

    Values(i) = SBMLModel.species(i).initialAmount;

    if (SBMLModel.SBML_level == 2)
        if (SBMLModel.species(i).isSetInitialConcentration)
            Values(i) = SBMLModel.species(i).initialConcentration;
        end;
    end;
    % might be an initial assignment in l2v2
    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)

        % remove this from the substtution
        newSBMLModel = SBMLModel;
        newSBMLModel.species(i) = [];
        for ia = 1:length(SBMLModel.initialAssignment)
            if (strcmp(SBMLModel.initialAssignment(ia).symbol, name))
                Values(i) = Substitute(SBMLModel.initialAssignment(ia).math, newSBMLModel);
            end;
        end;
    end;
end;

%--------------------------------------------------------------------------
% assign output

if (NumSpecies ~= 0)
    varargout{1} = CharArray;
    varargout{2} = Values;
else
    varargout{1} = [];
    varargout{2} = [];
end;
