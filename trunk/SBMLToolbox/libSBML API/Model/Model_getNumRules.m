function number = Model_getNumRules(SBMLModel)
%
%   Model_getNumRules 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of rule structures defined within the model
%
%       number = Model_getNumRules(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumRules(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.rule))
    number = length(SBMLModel.rule);
end;