function SBMLModel = Model_addCompartment(SBMLModel, SBMLCompartment)
%
%   Model_addCompartment 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLCompartment structure
%
%             and returns 
%               the model with the compartment added
%
%       SBMLModel = Model_addCompartment(SBMLModel, SBMLCompartment)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addCompartment(SBMLModel, SBMLCompartment)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addCompartment(SBMLModel, SBMLCompartment)', 'second argument must be an SBML compartment structure', sbmlLevel));
end;

numberCompartments = length(SBMLModel.compartment);

SBMLModel.compartment(numberCompartments+1) = SBMLCompartment;

