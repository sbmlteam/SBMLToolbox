function [unit, SBMLModel] = Model_createUnit(SBMLModel)
%
%   Model_createUnit 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the unit structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created unit
%
%       NOTE: the units is added to the last unit definition created
%
%       [unit, SBMLModel] = Model_createUnit(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createUnit(SBMLModel)', 'first argument must be an SBML model structure'));
end;

unit = Unit_create(SBMLModel.SBML_level);

if (length(SBMLModel.unitDefinition) == 0)
    unit = [];
    warning('Failed to create unit');
else
    SBMLModel.unitDefinition(end) = UnitDefinition_addUnit(SBMLModel.unitDefinition(end), unit);
end;

