function id = Model_getId(SBMLModel)
%
%   Model_getId 
%             takes an SBMLModel structure 
%
%             and returns 
%               the id of the model as a string
%
%       id = Model_getId(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getId(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_getId(SBMLModel)', 'no id field in a level 1 model'));    
end;

id = SBMLModel.id;