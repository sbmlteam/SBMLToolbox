function Event = Event_create
%
%   Event_create 
%             returns 
%               a event structure
%
%       Event = Event_create

%default level = 2
sbmlLevel = 2;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'Event_create(sbmlLevel)', 'requires no arguments', 'SEE help Event_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'trigger', 'delay', 'timeUnits', 'eventAssignment'};
Values = {'SBML_EVENT', '', '', '', '', '', '', '', []};

Event = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_Event(Event, sbmlLevel))
    Event = [];
    warning('Failed to create event');
end;
