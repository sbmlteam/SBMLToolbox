function compartments = Model_getListOfCompartments(SBMLModel)
%
%   Model_getListOfCompartments 
%             takes an SBMLModel structure 
%
%             and returns 
%               an array of SBML compartment structures defined within the model
%
%       compartments = Model_getListOfCompartments(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getListOfCompartments(SBMLModel)', 'argument must be an SBML model structure'));
end;

compartments = SBMLModel.compartment;