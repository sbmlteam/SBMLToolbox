function value = Model_isSetId(SBMLModel)
%
%   Model_isSetId 
%             takes an SBMLModel structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = Model_isSetId(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_isSetId(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_isSetId(SBMLModel)', 'no id field in a level 1 model'));    
end;

value = ~isempty(SBMLModel.id);