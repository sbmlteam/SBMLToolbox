function SBMLEvent = Event_unsetId(SBMLEvent)
%
%   Event_unsetId 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the event with the id unset
%               (i.e. id = '')
%
%       SBMLEvent = Event_unsetId(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_unsetId(SBMLEvent)', 'argument must be an SBML event structure'));
end;

SBMLEvent.id = '';
