function reaction = Model_getReaction(SBMLModel, number)
%
%   Model_getReaction 
%             takes  1) an SBMLModel structure 
%             and    2) a number n
%
%             and returns 
%               the nth reaction structure defined within the model
%
%       reaction = Model_getReaction(SBMLModel, number)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getReaction(SBMLModel, number)', 'first argument must be an SBML model structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Model_getReaction(SBMLModel, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLModel.reaction))
    reaction = [];
else
    reaction = SBMLModel.reaction(number);
end;