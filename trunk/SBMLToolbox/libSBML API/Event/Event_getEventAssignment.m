function eventAssignment = Event_getEventAssignment(SBMLEvent, number)
%
%   Event_getEventAssignment 
%             takes  1) an SBMLEvent structure 
%             and    2) a number n
%
%             and returns 
%               the nth eventAssignment structure defined within the event
%
%       eventAssignment = Event_getEventAssignment(SBMLEvent, number)

% get level
sbmlLevel = 2;
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getEventAssignment(SBMLEvent, number)', 'first argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_getEventAssignment(SBMLEvent, number)', 'no events in level 1 model'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Event_getEventAssignment(SBMLEvent, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLEvent.eventAssignment))
    eventAssignment = [];
else
    eventAssignment = SBMLEvent.eventAssignment(number);
end;
