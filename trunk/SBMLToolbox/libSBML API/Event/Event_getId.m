function id = Event_getId(SBMLEvent)
%
%   Event_getId 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the id of the event as a string
%
%       id = Event_getId(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getId(SBMLEvent)', 'argument must be an SBML event structure'));
end;

id = SBMLEvent.id;
