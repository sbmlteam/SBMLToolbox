function number = Model_getNumUnitDefinitions(SBMLModel)
%
%   Model_getNumUnitDefinitions 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of unit definition structures defined within the model
%
%       number = Model_getNumUnitDefinitions(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumUnitDefinitions(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.unitDefinition))
    number = length(SBMLModel.unitDefinition);
end;