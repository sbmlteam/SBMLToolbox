function value = Event_isSetDelay(SBMLEvent)
%
%   Event_isSetDelay 
%             takes an SBMLEvent structure 
%
%             and returns 
%               1 if the delay has been set 
%               0 otherwise
%
%       value = Event_isSetDelay(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_isSetDelay(SBMLEvent)', 'argument must be an SBML event structure'));
end;

value = ~isempty(SBMLEvent.delay);
