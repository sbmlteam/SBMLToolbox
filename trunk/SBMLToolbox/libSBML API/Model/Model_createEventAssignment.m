function [eventAssignment, SBMLModel] = Model_createEventAssignment(SBMLModel)
%
%   Model_createEventAssignment 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the eventAssignment structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created eventAssignment
%
%       NOTE: the eventAssignment is added to the last event created
%
%       [eventAssignment, SBMLModel] = Model_createEventAssignment(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createEventAssignment(SBMLModel)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_createEventAssignment(SBMLModel)', 'no events in a level 1 model'));
end;

eventAssignment = EventAssignment_create;

if (length(SBMLModel.event) == 0)
    eventAssignment = [];
    warning('Failed to create eventAssignment');
else
    SBMLModel.event(end) = Event_addEventAssignment(SBMLModel.event(end), eventAssignment);
end;

