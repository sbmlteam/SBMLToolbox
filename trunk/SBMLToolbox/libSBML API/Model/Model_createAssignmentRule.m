function [assignmentRule, SBMLModel] = Model_createAssignmentRule(SBMLModel)
%
%   Model_createAssignmentRule 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the assignmentRule structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created assignmentRule
%
%       [assignmentRule, SBMLModel] = Model_createAssignmentRule(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createAssignmentRule(SBMLModel)', 'first argument must be an SBML model structure'));
end;

assignmentRule = AssignmentRule_create(SBMLModel.SBML_level);

SBMLModel = Model_addRule(SBMLModel, assignmentRule);
