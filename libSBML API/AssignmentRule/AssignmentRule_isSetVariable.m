function value = AssignmentRule_isSetVariable(SBMLAssignmentRule)
%
%   AssignmentRule_isSetVariable 
%             takes an SBMLAssignmentRule structure 
%
%             and returns 
%               1 if the variable has been set 
%               0 otherwise
%
%       value = AssignmentRule_isSetVariable(SBMLAssignmentRule)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_AssignmentRule(SBMLAssignmentRule, sbmlLevel))
    error(sprintf('%s\n%s', 'AssignmentRule_isSetVariable(SBMLAssignmentRule)', 'argument must be an SBML assignmentRule structure'));
end;

value = ~isempty(SBMLAssignmentRule.variable);
