function SBMLEvent = Event_setId(SBMLEvent, id)
%
%   Event_setId 
%             takes  1) an SBMLEvent structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the functionDefinition with the id set
%
%       SBMLEvent = Event_setId(SBMLEvent, 'id')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_setId(SBMLEvent, id)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(id))
    error(sprintf('Event_setId(SBMLEvent, id)\n%s', 'second argument must be a string representing the id of the functionDefinition'));
end;

SBMLEvent.id = id;
