function event = Model_getEventById(SBMLModel, id)
%
%   Model_getEventById 
%             takes  1) an SBMLModel structure 
%             and    2) a string representing the id of the event to be found
%
%             and returns 
%               the event structure with the matching id 
%               or an empty structure if no such event exists
%               
%       event = Model_getEventById(SBMLModel, 'id')

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getEventById(SBMLModel, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Model_getEventById(SBMLModel, id)', 'second argument must be a string'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getEventById(SBMLModel, id)', 'no events in a level 1 model'));   
end;

event = [];

for i = 1:length(SBMLModel.event)
    if (strcmp(id, SBMLModel.event(i).id))
        event = SBMLModel.event(i);
        return;
    end;
end;