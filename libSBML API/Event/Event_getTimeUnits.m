function timeUnits = Event_getTimeUnits(SBMLEvent)
%
%   Event_getTimeUnits 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the timeUnits of the event as a string
%
%       timeUnits = Event_getTimeUnits(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getTimeUnits(SBMLEvent)', 'argument must be an SBML event structure'));
end;

timeUnits = SBMLEvent.timeUnits;
