function SBMLAssignmentRule = AssignmentRule_setVariable(SBMLAssignmentRule, variable)
%
%   AssignmentRule_setVariable 
%             takes  1) an SBMLAssignmentRule structure 
%             and    2) a string representing the variable to be set
%
%             and returns 
%               the assignmentRule with the variable set
%
%       SBMLAssignmentRule = AssignmentRule_setVariable(SBMLAssignmentRule, 'variable')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    error(sprintf('%s\n%s', 'AssignmentRule_setVariable(SBMLAssignmentRule, variable)', 'first argument must be an SBML assignmentRule structure'));
elseif (~ischar(variable))
    error(sprintf('AssignmentRule_setVariable(SBMLAssignmentRule, variable)\n%s', 'second argument must be a string representing the variable of the assignmentRule'));
end;

SBMLAssignmentRule.variable = variable;
