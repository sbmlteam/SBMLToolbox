function variable = AssignmentRule_getVariable(SBMLAssignmentRule)
%
%   AssignmentRule_getVariable 
%             takes an SBMLAssignmentRule structure 
%
%             and returns 
%               the variable of the assignmentRule as a string
%
%       variable = AssignmentRule_getVariable(SBMLAssignmentRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    error(sprintf('%s\n%s', 'AssignmentRule_getVariable(SBMLAssignmentRule)', 'argument must be an SBML assignmentRule structure'));
end;

variable = SBMLAssignmentRule.variable;
