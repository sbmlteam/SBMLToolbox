function event = Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)
%
%   Event_addEventAssignment 
%             takes  1) an SBMLEvent structure 
%             and    2) an SBMLEventAssignment structure
%
%             and returns 
%               the event with the eventAssignment added
%
%       event = Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)

% get level
sbmlLevel = 2;
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'first argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'no events in level 1 model'));
elseif (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'second argument must be an SBML eventAssignment structure'));
end;

numberEventAssignments = length(SBMLEvent.eventAssignment);

SBMLEvent.eventAssignment(numberEventAssignments+1) = SBMLEventAssignment;

event = SBMLEvent;

