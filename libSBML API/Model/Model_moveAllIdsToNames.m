function SBMLModel = Model_moveAllIdsToNames(SBMLModel)
%
%   Model_moveAllIdsToNames 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with all ids moved to the name field 
%               (unless the name field is already set)
%
%       SBMLModel = Model_moveAllIdsToNames(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveAllIdsToNames(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveAllIdsToNames(SBMLModel)', 'no id field in a level 1 model'));    
end;

SBMLModel = Model_moveIdToName(SBMLModel);

for i = 1:length(SBMLModel.functionDefinition)
    SBMLModel.functionDefinition(i) = FunctionDefinition_moveIdToName(SBMLModel.functionDefinition(i));
end;

for i = 1:length(SBMLModel.unitDefinition)
    SBMLModel.unitDefinition(i) = UnitDefinition_moveIdToName(SBMLModel.unitDefinition(i));
end;

for i = 1:length(SBMLModel.compartment)
    SBMLModel.compartment(i) = Compartment_moveIdToName(SBMLModel.compartment(i));
end;

for i = 1:length(SBMLModel.species)
    SBMLModel.species(i) = Species_moveIdToName(SBMLModel.species(i));
end;

for i = 1:length(SBMLModel.parameter)
    SBMLModel.parameter(i) = Parameter_moveIdToName(SBMLModel.parameter(i));
end;

for i = 1:length(SBMLModel.reaction)
    SBMLModel.reaction(i) = Reaction_moveIdToName(SBMLModel.reaction(i));
end;

for i = 1:length(SBMLModel.event)
    SBMLModel.event(i) = Event_moveIdToName(SBMLModel.event(i));
end;

