function SBMLModel = Model_moveNameToId(SBMLModel)
%
%   Model_moveNameToId 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLModel = Model_moveNameToId(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveNameToId(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveNameToId(SBMLModel)', 'no id field in a level 1 model'));    
end;

if (~Model_isSetId(SBMLModel))
    name = Model_getName(SBMLModel);
    SBMLModel = Model_setId(SBMLModel, name);
    SBMLModel = Model_setName(SBMLModel, '');
end;