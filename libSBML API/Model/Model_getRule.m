function rule = Model_getRule(SBMLModel, number)
%
%   Model_getRule 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth rule structure defined within the model
%
%       rule = Model_getRule(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getRule(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getRule(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.rule))
    rule = [];
else
    rule = SBMLModel.rule(number);
end;