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

% check that input is correct
sbmlLevel = 1;
if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    error(sprintf('%s\n%s', 'AssignmentRule_setType(SBMLAssignmentRule, type)', 'first argument must be an SBML assignmentRule structure'));
elseif(sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'AssignmentRule_setType(SBMLAssignmentRule, type)', 'no type field in level 2 model'));    
elseif (~ischar(type))
    error(sprintf('AssignmentRule_setType(SBMLAssignmentRule, type)\n%s\neither \''%s\'' or \''%s\''', 'second argument must be a string representing the type of the assignmentRule', 'rate', 'scalar'));
elseif ((~strcmp(type, 'rate')) && (~strcmp(type, 'scalar')))
    error(sprintf('AssignmentRule_setType(SBMLAssignmentRule, type)\n%s\neither \''%s\'' or \''%s\''', 'second argument must be a string representing the type of the assignmentRule', 'rate', 'scalar'));
end;

SBMLAssignmentRule.type = type;
