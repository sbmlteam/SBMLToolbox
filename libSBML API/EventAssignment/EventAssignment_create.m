function EventAssignment = EventAssignment_create
%
%   EventAssignment_create 
%             returns 
%               a eventAssignment structure
%
%       EventAssignment = EventAssignment_create

%default level = 2
sbmlLevel = 2;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'EventAssignment_create(sbmlLevel)', 'requires no arguments', 'SEE help EventAssignment_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'variable', 'math'};
Values = {'SBML_EVENT_ASSIGNMENT', '', '', '', ''};

EventAssignment = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_EventAssignment(EventAssignment, sbmlLevel))
    EventAssignment = [];
    warning('Failed to create eventAssignment');
end;
