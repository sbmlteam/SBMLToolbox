function SBMLEventAssignment = EventAssignment_setMath(SBMLEventAssignment, math)
%
%   EventAssignment_setMath 
%             takes  1) an SBMLEventAssignment structure 
%             and    2) a string representing the math to be set
%
%             and returns 
%               the eventAssignment with the math set
%
%       SBMLEventAssignment = EventAssignment_setMath(SBMLEventAssignment, 'math')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'EventAssignment_setMath(SBMLEventAssignment, math)', 'first argument must be an SBML eventAssignment structure'));
elseif (~ischar(math))
    error(sprintf('EventAssignment_setMath(SBMLEventAssignment, math)\n%s', 'second argument must be a string representing the math of the eventAssignment'));
end;

SBMLEventAssignment.math = math;
