function SBMLEvent = Event_unsetDelay(SBMLEvent)
%
%   Event_unsetDelay 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the event with the delay unset
%               (i.e. delay = '')
%
%       SBMLEvent = Event_unsetDelay(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_unsetDelay(SBMLEvent)', 'argument must be an SBML event structure'));
end;

SBMLEvent.delay = '';
