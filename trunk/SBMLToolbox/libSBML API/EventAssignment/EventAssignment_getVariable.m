function variable = EventAssignment_getVariable(SBMLEventAssignment)
%
%   EventAssignment_getVariable 
%             takes an SBMLEventAssignment structure 
%
%             and returns 
%               the variable of the eventAssignment as a string
%
%       variable = EventAssignment_getVariable(SBMLEventAssignment)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_getVariable(SBMLEventAssignment)', 'argument must be an SBML eventAssignment structure'));
end;

variable = SBMLEventAssignment.variable;
