function number = Model_getNumEvents(SBMLModel)
%
%   Model_getNumEvents 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of event structures defined within the model
%
%       number = Model_getNumEvents(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumEvents(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getNumEvents(SBMLModel)', 'no events in a level 1 model'));   
end;

number = 0;

if (~isempty(SBMLModel.event))
    number = length(SBMLModel.event);
end;