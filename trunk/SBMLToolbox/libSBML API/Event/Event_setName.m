function SBMLEvent = Event_setName(SBMLEvent, name)
%
%   Event_setName 
%             takes  1) an SBMLEvent structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the functionDefinition with the name set
%
%       SBMLEvent = Event_setName(SBMLEvent, 'name')

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_setName(SBMLEvent, name)', 'first argument must be an SBML functionDefinition structure'));
elseif (~ischar(name))
    error(sprintf('Event_setName(SBMLEvent, name)\n%s', 'second argument must be a string representing the name of the functionDefinition'));
end;

SBMLEvent.name = name;
