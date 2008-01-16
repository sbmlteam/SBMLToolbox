function varargout = GetCompartmentTypes(SBMLModel)
% GetCompartmentTypes takes a SBMLModel 
% and returns 
%           1) an array of character names of all compartmentTypes within the model 
%

%--------------------------------------------------------------------------
%
%  Filename    : GetCompartmentTypes.m
%  Description : returns compartmentTypes
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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
    error('GetCompartmentTypes(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% determine the number of compartmentTypes within the model
NumCompartmentTypes = length(SBMLModel.compartmentType);

%------------------------------------------------------------
% loop through the list of compartments
for i = 1:NumCompartmentTypes

    % and array of the character names
    CharArray{i} = SBMLModel.compartmentType(i).id;

end;

%--------------------------------------------------------------------------
% assign output

if (NumCompartmentTypes ~= 0)
    varargout{1} = CharArray;
else
    varargout{1} = [];
end;
