function parameter = Model_getParameter(SBMLModel, number)
%
%   Model_getParameter 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth parameter structure defined within the model
%
%       parameter = Model_getParameter(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getParameter(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getParameter(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.parameter))
    parameter = [];
else
    parameter = SBMLModel.parameter(number);
end;