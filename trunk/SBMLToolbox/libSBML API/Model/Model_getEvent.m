function event = Model_getEvent(SBMLModel, number)
%
%   Model_getEvent 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth event structure defined within the model
%
%       event = Model_getEvent(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getEvent(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getEvent(SBMLModel, number)', 'no events in level 1 model'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getEvent(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.event))
    event = [];
else
    event = SBMLModel.event(number);
end;