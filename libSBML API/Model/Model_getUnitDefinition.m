function unitDefinition = Model_getUnitDefinition(SBMLModel, number)
%
%   Model_getUnitDefinition 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth unit definition structure defined within the model
%
%       unitDefinition = Model_getUnitDefinition(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getUnitDefinition(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getUnitDefinition(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.unitDefinition))
    unitDefinition = [];
else
    unitDefinition = SBMLModel.unitDefinition(number);
end;