function SBMLModel = Model_addRule(SBMLModel, SBMLRule)
%
%   Model_addRule 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLRule structure
%
%             and returns 
%               the model with the rule added
%
%       SBMLModel = Model_addRule(SBMLModel, SBMLRule)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addRule(SBMLModel, SBMLRule)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Rule(SBMLRule, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addRule(SBMLModel, SBMLRule)', 'second argument must be an SBML rule structure', sbmlLevel));
end;

numberRules = length(SBMLModel.rule);

SBMLModel.rule(numberRules+1) = SBMLRule;

