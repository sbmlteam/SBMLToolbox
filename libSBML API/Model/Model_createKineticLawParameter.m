function [kineticLawParameter, SBMLModel] = Model_createKineticLawParameter(SBMLModel)
%
%   Model_createKineticLawParameter 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the kineticLawParameter structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created kineticLawParameter
%
%       NOTE: the kineticLawParameter is added to the last reaction created
%
%       [kineticLawParameter, SBMLModel] = Model_createKineticLawParameter(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createKineticLawParameter(SBMLModel)', 'first argument must be an SBML model structure'));
end;

kineticLawParameter = Parameter_create(SBMLModel.SBML_level);

if (length(SBMLModel.reaction) == 0)
    kineticLawParameter = [];
    warning('Failed to create kineticLawParameter');
elseif (isempty(Reaction_getKineticLaw(SBMLModel.reaction(end))))
    kineticLawParameter = [];
    warning('No KineticLaw created for this reaction');  
else
    SBMLModel.reaction(end).kineticLaw = KineticLaw_addParameter(SBMLModel.reaction(end).kineticLaw, kineticLawParameter);
end;

