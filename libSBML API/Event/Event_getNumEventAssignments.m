function number = Event_getNumEventAssignments(SBMLEvent)
%
%   Event_getNumEventAssignments 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the number of eventAssignment structures defined within the event
%
%       number = Event_getNumEventAssignments(SBMLEvent)

% get level
sbmlLevel = 2;
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getNumEventAssignments(SBMLEvent)', 'argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_getNumEventAssignments(SBMLEvent)', 'no events in a level 1 model'));   
end;

number = 0;

if (~isempty(SBMLEvent.eventAssignment))
    number = length(SBMLEvent.eventAssignment);
end;
