function number = Model_getNumCompartments(SBMLModel)
%
%   Model_getNumCompartments 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of compartment structures defined within the model
%
%       number = Model_getNumCompartments(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumCompartments(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.compartment))
    number = length(SBMLModel.compartment);
end;