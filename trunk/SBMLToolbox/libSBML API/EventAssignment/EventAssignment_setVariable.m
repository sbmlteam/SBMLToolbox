function SBMLEventAssignment = EventAssignment_setVariable(SBMLEventAssignment, variable)
%
%   EventAssignment_setVariable 
%             takes  1) an SBMLEventAssignment structure 
%             and    2) a string representing the variable to be set
%
%             and returns 
%               the eventAssignment with the variable set
%
%       SBMLEventAssignment = EventAssignment_setVariable(SBMLEventAssignment, 'variable')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_setVariable(SBMLEventAssignment, variable)', 'first argument must be an SBML eventAssignment structure'));
elseif (~ischar(variable))
    error(sprintf('EventAssignment_setVariable(SBMLEventAssignment, variable)\n%s', 'second argument must be a string representing the variable of the eventAssignment'));
end;

SBMLEventAssignment.variable = variable;
