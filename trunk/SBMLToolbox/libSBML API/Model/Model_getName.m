function name = Model_getName(SBMLModel)
%
%   Model_getName 
%             takes an SBMLModel structure 
%
%             and returns 
%               the name of the model as a string
%
%       name = Model_getName(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getName(SBMLModel)', 'argument must be an SBML model structure'));
end;

name = SBMLModel.name;