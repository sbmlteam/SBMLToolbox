function value = Event_isSetName(SBMLEvent)
%
%   Event_isSetName 
%             takes an SBMLEvent structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = Event_isSetName(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_isSetName(SBMLEvent)', 'argument must be an SBML event structure'));
end;

value = ~isempty(SBMLEvent.name);