function compartment = Model_getCompartment(SBMLModel, number)
%
%   Model_getCompartment 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth compartment structure defined within the model
%
%       compartment = Model_getCompartment(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getCompartment(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getCompartment(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.compartment))
    compartment = [];
else
    compartment = SBMLModel.compartment(number);
end;