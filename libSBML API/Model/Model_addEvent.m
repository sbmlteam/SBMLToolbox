function SBMLModel = Model_addEvent(SBMLModel, SBMLEvent)
%
%   Model_addEvent 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLEvent structure
%
%             and returns 
%               the model with the event added
%
%       SBMLModel = Model_addEvent(SBMLModel, SBMLEvent)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addEvent(SBMLModel, SBMLEvent)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Event(SBMLEvent, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addEvent(SBMLModel, SBMLEvent)', 'second argument must be an SBML event structure', sbmlLevel));
end;

numberEvents = length(SBMLModel.event);

SBMLModel.event(numberEvents+1) = SBMLEvent;

