function SBMLModel = Model_moveIdToName(SBMLModel)
%
%   Model_moveIdToName 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLModel = Model_moveIdToName(SBMLModel)

%  Filename    :   Model_moveIdToName.m
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
    error(sprintf('%s\n%s', 'Model_moveIdToName(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveIdToName(SBMLModel)', 'no id field in a level 1 model'));    
end;

if (~Model_isSetName(SBMLModel))
    id = Model_getId(SBMLModel);
    SBMLModel = Model_setName(SBMLModel, id);
    SBMLModel = Model_setId(SBMLModel, '');
end;
