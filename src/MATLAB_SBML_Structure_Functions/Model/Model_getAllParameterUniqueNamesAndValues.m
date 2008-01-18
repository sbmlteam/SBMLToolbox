function varargout = Model_getAllParameterUniqueNamesAndValues(SBMLModel)
% Model_getAllParameterUniqueNamesAndValues takes a SBMLModel 
% and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%               with reaction names appended to the names of parameters
%               declared within a reaction
%           2) an array of the values of each parameter
%

%  Filename    :   Model_getAllParameterUniqueNamesAndValues.m
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
    error('Model_getAllParameterUniqueNamesAndValues(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% get the global parameters
[ParamChar, ParamValues] = GetGlobalParameters(SBMLModel);

% get number of parameters
NumParams = length(ParamChar);
%------------------------------------------------------------
% get the number of reactions within the model
NumReactions = length(SBMLModel.reaction);

%------------------------------------------------------------
% loop through the list of reactions
for i = 1:NumReactions
    
    % get parameters within each reaction
    [Char, Value] = GetParameterFromReactionUnique(SBMLModel.reaction(i));
    
    % add to existing arrays
    for j = 1:length(Char)
        NumParams = NumParams + 1;
        ParamValues(NumParams) = Value(j);
        ParamChar{NumParams} = Char{j};
    end;
    
end;

%--------------------------------------------------------------------------
% assign output

varargout{1} = ParamChar;
varargout{2} = ParamValues;
