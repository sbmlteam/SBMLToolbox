function SBMLModel = Model_moveIdToName(SBMLModel)
%
%   Model_moveIdToName 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLModel = Model_moveIdToName(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveIdToName(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveIdToName(SBMLModel)', 'no id field in a level 1 model'));    
end;

if (~Model_isSetName(SBMLModel))
    id = Model_getId(SBMLModel);
    SBMLModel = Model_setName(SBMLModel, id);
    SBMLModel = Model_setId(SBMLModel, '');
end;