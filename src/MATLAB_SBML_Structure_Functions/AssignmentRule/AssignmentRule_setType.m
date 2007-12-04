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
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


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
