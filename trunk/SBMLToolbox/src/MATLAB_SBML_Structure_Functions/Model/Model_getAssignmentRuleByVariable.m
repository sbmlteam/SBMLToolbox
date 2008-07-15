function rule = Model_getAssignmentRuleByVariable(SBMLModel, variable)
%
%   Model_getAssignmentRuleByVariable 
%             takes  1) an SBMLModel structure 
%             and    2) a string variable
%
%             and returns 
%               the assignment rule structure defined within the model
%               that assigns value to the variable given
%
%       rule = Model_getAssignmentRuleByVariable(SBMLModel, variable)

%  Filename    :   Model_getAssignmentRuleByVariable.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id:  Exp $
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
    error(sprintf('%s\n%s', 'Model_getAssignmentRuleByVariable(SBMLModel, variable)', 'first argument must be an SBML model structure'));
elseif (~ischar(variable))
    error(sprintf('%s\n%s', 'Model_getAssignmentRuleByVariable(SBMLModel, variable)', 'second argument must be a string'));
end;

rule = [];

% get level and version
sbmlLevel = SBMLModel.SBML_level;
sbmlVersion = SBMLModel.SBML_version;

for i = 1:length(SBMLModel.rule)
  if (isSBML_AssignmentRule(SBMLModel.rule(i), sbmlLevel, sbmlVersion))
    if (strcmp(variable, AssignmentRule_getVariable(SBMLModel.rule(i))))
      rule = SBMLModel.rule(i);
      return;
    end;
  end;
end;
