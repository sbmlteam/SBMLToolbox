function eventAssignments = Event_getListOfEventAssignments(SBMLEvent)
%
%   Event_getListOfEventAssignments 
%             takes an SBMLEvent structure 
%
%             and returns 
%               an array of SBML eventAssignment structures defined within the event
%
%       eventAssignments = Event_getListOfEventAssignments(SBMLEvent)

% get level
sbmlLevel = 2;
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s', 'Event_getListOfEventAssignments(SBMLEvent)', 'argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_getListOfEventAssignments(SBMLEvent)', 'no events in a level 1 model'));    
end;

eventAssignments = SBMLEvent.eventAssignment;
