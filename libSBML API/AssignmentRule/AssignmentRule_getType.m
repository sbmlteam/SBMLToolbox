function type = AssignmentRule_getType(SBMLAssignmentRule)
%
%   AssignmentRule_getType 
%             takes an SBMLAssignmentRule structure 
%
%             and returns 
%               the type of the assignmentRule as a string
%
%       type = AssignmentRule_getType(SBMLAssignmentRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    error(sprintf('%s\n%s', 'AssignmentRule_getType(SBMLAssignmentRule)', 'argument must be an SBML assignmentRule structure'));
elseif(sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'AssignmentRule_getType(SBMLAssignmentRule)', 'no type field in level 2 model'));    
end;

type = SBMLAssignmentRule.type;
