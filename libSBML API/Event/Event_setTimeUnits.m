function SBMLEvent = Event_setTimeUnits(SBMLEvent, timeUnits)
%
%   Event_setTimeUnits 
%             takes  1) an SBMLEvent structure 
%             and    2) a string representing the timeUnits to be set
%
%             and returns 
%               the event with the timeUnits set
%
%       SBMLEvent = Event_setTimeUnits(SBMLEvent, 'timeUnits')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_setTimeUnits(SBMLEvent, timeUnits)', 'first argument must be an SBML event structure'));
elseif (~ischar(timeUnits))
    error(sprintf('Event_setTimeUnits(SBMLEvent, timeUnits)\n%s', 'second argument must be a string representing the timeUnits of the event'));
end;

SBMLEvent.timeUnits = timeUnits;
