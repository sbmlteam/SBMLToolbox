function trigger = Event_getTrigger(SBMLEvent)
%
%   Event_getTrigger 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the trigger of the event as a string
%
%       trigger = Event_getTrigger(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getTrigger(SBMLEvent)', 'argument must be an SBML event structure'));
end;

trigger = SBMLEvent.trigger;
