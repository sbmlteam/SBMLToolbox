function value = Model_isSetName(SBMLModel)
%
%   Model_isSetName 
%             takes an SBMLModel structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = Model_isSetName(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_isSetName(SBMLModel)', 'argument must be an SBML model structure'));
end;

value = ~isempty(SBMLModel.name);