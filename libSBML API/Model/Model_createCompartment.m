function [compartment, SBMLModel] = Model_createCompartment(SBMLModel)
%
%   Model_createCompartment 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the compartment structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created compartment
%
%       [compartment, SBMLModel] = Model_createCompartment(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createCompartment(SBMLModel)', 'first argument must be an SBML model structure'));
end;

compartment = Compartment_create(SBMLModel.SBML_level);

SBMLModel = Model_addCompartment(SBMLModel, compartment);
