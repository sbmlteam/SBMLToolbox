function SBMLAssignmentRule = AssignmentRule_setType(SBMLAssignmentRule, type)
%
%   AssignmentRule_setType 
%             takes  1) an SBMLAssignmentRule structure 
%             and    2) a string representing the type to be set
%
%             and returns 
%               the assignmentRule with the type set
%
%       type must be either 'rate' or 'scalar'
%
%       SBMLAssignmentRule = AssignmentRule_setType(SBMLAssignmentRule, 'type')

%  Filename    :   AssignmentRule_setType.m
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
if (~isstruct(SBMLAssignmentRule))
    error(sprintf('%s\n%s', ...
      'AssignmentRule_setType(SBMLAssignmentRule)', ...
      'argument must be an SBML assignmentRule structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLAssignmentRule);

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'AssignmentRule_setType(SBMLAssignmentRule, type)', 'first argument must be an SBML assignmentRule structure'));
elseif(sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'AssignmentRule_setType(SBMLAssignmentRule, type)', 'no type field in level 2 model'));    
elseif (~ischar(type))
    error(sprintf('AssignmentRule_setType(SBMLAssignmentRule, type)\n%s\neither \''%s\'' or \''%s\''', 'second argument must be a string representing the type of the assignmentRule', 'rate', 'scalar'));
elseif ((~strcmp(type, 'rate')) && (~strcmp(type, 'scalar')))
    error(sprintf('AssignmentRule_setType(SBMLAssignmentRule, type)\n%s\neither \''%s\'' or \''%s\''', 'second argument must be a string representing the type of the assignmentRule', 'rate', 'scalar'));
end;

SBMLAssignmentRule.type = type;
