function [event, SBMLModel] = Model_createEvent(SBMLModel)
%
%   Model_createEvent 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the event structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created event
%
%       [event, SBMLModel] = Model_createEvent(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createEvent(SBMLModel)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_createEvent(SBMLModel)', 'no function definitions in a level 1 model'));   
end;

event = Event_create;

SBMLModel = Model_addEvent(SBMLModel, event);
