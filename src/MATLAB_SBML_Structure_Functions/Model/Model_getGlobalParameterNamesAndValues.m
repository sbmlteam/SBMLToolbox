function varargout = Model_getGlobalParameterNamesAndValues(SBMLModel)
% Model_getGlobalParameterNamesAndValues takes a SBMLModel 
% and returns 
%           1) an array of character names representing all global parameters within the model 
%           2) an array of the values of each parameter
%

%  Filename    :   Model_getGlobalParameterNamesAndValues.m
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
    error('Model_getGlobalParameterNamesAndValues(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of parameters within the model
NumParams = length(SBMLModel.parameter);

%------------------------------------------------------------
% loop through the list of parameters
for i = 1:NumParams
    
    %determine the name or id of the parameter
    if (SBMLModel.SBML_level == 1)
        name = SBMLModel.parameter(i).name;
    else
        if (isempty(SBMLModel.parameter(i).id))
            name = SBMLModel.parameter(i).name;
        else
            name = SBMLModel.parameter(i).id;
        end;
    end;
    
    % save into an array of character names
    CharArray{i} = name;
    
    % put the value into the array
    Values(i) = SBMLModel.parameter(i).value;
    
end;

%--------------------------------------------------------------------------
% assign output

if (NumParams ~= 0)
    varargout{1} = CharArray;
    varargout{2} = Values;
else
    varargout{1} = [];
    varargout{2} = [];
end;
