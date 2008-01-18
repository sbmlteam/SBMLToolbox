function SBMLModel = Model_moveNameToId(SBMLModel)
%
%   Model_moveNameToId 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLModel = Model_moveNameToId(SBMLModel)

%  Filename    :   Model_moveNameToId.m
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



% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveNameToId(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveNameToId(SBMLModel)', 'no id field in a level 1 model'));    
end;

if (~Model_isSetId(SBMLModel))
    name = Model_getName(SBMLModel);
    SBMLModel = Model_setId(SBMLModel, name);
    SBMLModel = Model_setName(SBMLModel, '');
end;
