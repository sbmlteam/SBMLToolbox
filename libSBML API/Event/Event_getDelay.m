function delay = Event_getDelay(SBMLEvent)
%
%   Event_getDelay 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the delay of the event as a string
%
%       delay = Event_getDelay(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getDelay(SBMLEvent)', 'argument must be an SBML event structure'));
end;

delay = SBMLEvent.delay;
