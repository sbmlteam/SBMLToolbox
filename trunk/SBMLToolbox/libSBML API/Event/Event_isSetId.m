function value = Event_isSetId(SBMLEvent)
%
%   Event_isSetId 
%             takes an SBMLEvent structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = Event_isSetId(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_isSetId(SBMLEvent)', 'argument must be an SBML event structure'));
end;

value = ~isempty(SBMLEvent.id);
