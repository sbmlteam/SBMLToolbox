function varargout = Model_getSpeciesNamesAndInitialValues(SBMLModel)
% Model_getSpeciesNamesAndInitialValues takes a SBMLModel 
% and returns 
%           1) an array of character names of all species within the model 
%           2) an array of the initial concentration values of each species
%
% NOTE: if the initial concentrations are not set then the value NaN is used

%  Filename    :   Model_getSpeciesNamesAndInitialValues.m
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


% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('Model_getSpeciesNamesAndInitialValues(SBMLModel)\n%s', 'input must be an SBMLModel structure');
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
