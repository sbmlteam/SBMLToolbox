function SBMLEvent = Event_setTrigger(SBMLEvent, trigger)
%
%   Event_setTrigger 
%             takes  1) an SBMLEvent structure 
%             and    2) a string representing the trigger to be set
%
%             and returns 
%               the event with the trigger set
%
%       SBMLEvent = Event_setTrigger(SBMLEvent, 'trigger')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_setTrigger(SBMLEvent, trigger)', 'first argument must be an SBML event structure'));
elseif (~ischar(trigger))
    error(sprintf('Event_setTrigger(SBMLEvent, trigger)\n%s', 'second argument must be a string representing the trigger of the event'));
end;

SBMLEvent.trigger = trigger;
