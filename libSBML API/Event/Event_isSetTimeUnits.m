function value = Event_isSetTimeUnits(SBMLEvent)
%
%   Event_isSetTimeUnits 
%             takes an SBMLEvent structure 
%
%             and returns 
%               1 if the timeUnits has been set 
%               0 otherwise
%
%       value = Event_isSetTimeUnits(SBMLEvent)

% check that input is correct
sbmlLevel = 2;

if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_isSetTimeUnits(SBMLEvent)', 'argument must be an SBML event structure'));
end;

value = ~isempty(SBMLEvent.timeUnits);
