function SBMLEvent = Event_unsetTimeUnits(SBMLEvent)
%
%   Event_unsetTimeUnits 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the event with the timeUnits unset
%               (i.e. timeUnits = '')
%
%       SBMLEvent = Event_unsetTimeUnits(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_unsetTimeUnits(SBMLEvent)', 'argument must be an SBML event structure'));
end;

SBMLEvent.timeUnits = '';
