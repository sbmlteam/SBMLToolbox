function SBMLModel = Model_addParameter(SBMLModel, SBMLParameter)
%
%   Model_addParameter 
%             takes  1) an SBMLModel structure 
%             and    2) an SBMLParameter structure
%
%             and returns 
%               the model with the parameter added
%
%       SBMLModel = Model_addParameter(SBMLModel, SBMLParameter)

% get level
sbmlLevel = SBMLModel.SBML_level;

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_addParameter(SBMLModel, SBMLParameter)', 'first argument must be an SBML model structure'));
elseif (~isSBML_Parameter(SBMLParameter, sbmlLevel))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'Model_addParameter(SBMLModel, SBMLParameter)', 'second argument must be an SBML parameter structure', sbmlLevel));
end;

numberParameters = length(SBMLModel.parameter);

SBMLModel.parameter(numberParameters+1) = SBMLParameter;

