function number = Model_getNumParameters(SBMLModel)
%
%   Model_getNumParameters 
%             takes an SBMLModel structure 
%
%             and returns 
%               the number of parameter structures defined within the model
%
%       number = Model_getNumParameters(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getNumParameters(SBMLModel)', 'argument must be an SBML model structure'));
end;

number = 0;

if (~isempty(SBMLModel.parameter))
    number = length(SBMLModel.parameter);
end;