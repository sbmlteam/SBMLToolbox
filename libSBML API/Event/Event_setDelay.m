function SBMLEvent = Event_setDelay(SBMLEvent, delay)
%
%   Event_setDelay 
%             takes  1) an SBMLEvent structure 
%             and    2) a string representing the delay to be set
%
%             and returns 
%               the event with the delay set
%
%       SBMLEvent = Event_setDelay(SBMLEvent, 'delay')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_setDelay(SBMLEvent, delay)', 'first argument must be an SBML event structure'));
elseif (~ischar(delay))
    error(sprintf('Event_setDelay(SBMLEvent, delay)\n%s', 'second argument must be a string representing the delay of the event'));
end;

SBMLEvent.delay = delay;
