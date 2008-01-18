function y = Model_getNumAssignmentRules(SBMLModel)
% Model_getNumAssignmentRules takes a MATLAB_SBML model structure
% and returns the number of assignment rules in the model

%  Filename    :   Model_getNumAssignmentRules.m
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


y = 0;

%------------------------------------------------------------
% get level
SBMLLevel = SBMLModel.SBML_level;

for i = 1:length(SBMLModel.rule)
    if (strcmp(SBMLModel.rule(i).typecode, 'SBML_ASSIGNMENT_RULE'))
        y = y + 1;
    elseif(SBMLLevel == 1) 
        if ((strcmp(SBMLModel.rule(i).typecode, 'SBML_SPECIES_CONCENTRATION_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            y = y + 1;
        elseif ((strcmp(SBMLModel.rule(i).typecode, 'SBML_COMPARTMENT_VOLUME_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            y = y + 1;
        elseif ((strcmp(SBMLModel.rule(i).typecode, 'SBML_PARAMETER_RULE')) & (strcmp(SBMLModel.rule(i).type, 'scalar')))
            y = y + 1;
        end;
    end;
end;
