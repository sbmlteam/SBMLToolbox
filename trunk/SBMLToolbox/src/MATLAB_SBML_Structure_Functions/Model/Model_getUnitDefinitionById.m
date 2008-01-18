function unitDefinition = Model_getUnitDefinitionById(SBMLModel, id)
%
%   Model_getUnitDefinitionById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the unit definition to be found
%
%             and returns 
%               the unit definition structure with the matching id 
%               or an empty structure if no such unit definition exists
%               
%       unitDefinition = Model_getUnitDefinitionById(SBMLModel, 'id')

%  Filename    :   Model_getUnitDefinitionById.m
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
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getUnitDefinitionById(SBMLModel, id)', 'no id field in a level 1 model'));   
end;

unitDefinition = [];

for i = 1:length(SBMLModel.unitDefinition)
    if (strcmp(id, SBMLModel.unitDefinition(i).id))
        unitDefinition = SBMLModel.unitDefinition(i);
        return;
    end;
end;
