function SBMLModel = Model_unsetName(SBMLModel)
%
%   Model_unsetName 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with the name unset
%               (i.e. name = '')
%
%       SBMLModel = Model_unsetName(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_unsetName(SBMLModel)', 'argument must be an SBML model structure'));
end;

SBMLModel.name = '';