function value = Event_isSetTrigger(SBMLEvent)
%
%   Event_isSetTrigger 
%             takes an SBMLEvent structure 
%
%             and returns 
%               1 if the trigger has been set 
%               0 otherwise
%
%       value = Event_isSetTrigger(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_isSetTrigger(SBMLEvent)', 'argument must be an SBML event structure'));
end;

value = ~isempty(SBMLEvent.trigger);
