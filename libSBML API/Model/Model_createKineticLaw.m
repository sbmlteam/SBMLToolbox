function [kineticLaw, SBMLModel] = Model_createKineticLaw(SBMLModel)
%
%   Model_createKineticLaw 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the kineticLaw structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created kineticLaw
%
%       NOTE: the kineticLaw is added to the last reaction created
%
%       [kineticLaw, SBMLModel] = Model_createKineticLaw(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createKineticLaw(SBMLModel)', 'first argument must be an SBML model structure'));
end;

kineticLaw = KineticLaw_create(SBMLModel.SBML_level);

if (length(SBMLModel.reaction) == 0)
    kineticLaw = [];
    warning('Failed to create kineticLaw');
elseif (Reaction_isSetKineticLaw(SBMLModel.reaction(end)))
    kineticLaw = [];
    warning('KineticLaw already exists for this reaction');  
else
    SBMLModel.reaction(end) = Reaction_setKineticLaw(SBMLModel.reaction(end), kineticLaw);
end;

