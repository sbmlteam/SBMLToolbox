function events = Model_getListOfEvents(SBMLModel)
%
%   Model_getListOfEvents 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML event structures defined within the model
%
%       events = Model_getListOfEvents(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfEvents(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getListOfEvents(SBMLModel)', 'no events in a level 1 model'));    
end;

events = SBMLModel.event;