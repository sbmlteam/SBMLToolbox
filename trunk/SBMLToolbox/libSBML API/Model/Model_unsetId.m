function SBMLModel = Model_unsetId(SBMLModel)
%
%   Model_unsetId 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with the id unset
%               (i.e. id = '')
%
%       SBMLModel = Model_unsetId(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_unsetId(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_unsetId(SBMLModel)', 'no id field in a level 1 model'));    
end;

SBMLModel.id = '';