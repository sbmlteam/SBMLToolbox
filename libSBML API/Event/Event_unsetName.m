function SBMLEvent = Event_unsetName(SBMLEvent)
%
%   Event_unsetName 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the event with the name unset
%               (i.e. name = '')
%
%       SBMLEvent = Event_unsetName(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_unsetName(SBMLEvent)', 'argument must be an SBML event structure'));
end;

SBMLEvent.name = '';
