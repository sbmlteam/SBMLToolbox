function name = Event_getName(SBMLEvent)
%
%   Event_getName 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the name of the functionDefinition as a string
%
%       name = Event_getName(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getName(SBMLEvent)', 'argument must be an SBML functionDefinition structure'));
end;

name = SBMLEvent.name;
