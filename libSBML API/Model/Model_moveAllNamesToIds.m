function SBMLModel = Model_moveAllNamesToIds(SBMLModel)
%
%   Model_moveAllNamesToIds 
%             takes an SBMLModel structure 
%
%             and returns 
%               the model with all names moved to the id field 
%               (unless the id field is already set)
%
%       SBMLModel = Model_moveAllNamesToIds(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_moveAllNamesToIds(SBMLModel)', 'argument must be an SBML model structure'));
elseif (SBMLModel.SBML_level ~= 2)
    error(sprintf('%s\n%s', 'Model_moveAllNamesToIds(SBMLModel)', 'no id field in a level 1 model'));    
end;

SBMLModel = Model_moveNameToId(SBMLModel);

for i = 1:length(SBMLModel.functionDefinition)
    SBMLModel.functionDefinition(i) = FunctionDefinition_moveNameToId(SBMLModel.functionDefinition(i));
end;

for i = 1:length(SBMLModel.unitDefinition)
    SBMLModel.unitDefinition(i) = UnitDefinition_moveNameToId(SBMLModel.unitDefinition(i));
end;

for i = 1:length(SBMLModel.compartment)
    SBMLModel.compartment(i) = Compartment_moveNameToId(SBMLModel.compartment(i));
end;

for i = 1:length(SBMLModel.species)
    SBMLModel.species(i) = Species_moveNameToId(SBMLModel.species(i));
end;

for i = 1:length(SBMLModel.parameter)
    SBMLModel.parameter(i) = Parameter_moveNameToId(SBMLModel.parameter(i));
end;

for i = 1:length(SBMLModel.reaction)
    SBMLModel.reaction(i) = Reaction_moveNameToId(SBMLModel.reaction(i));
end;

for i = 1:length(SBMLModel.event)
    SBMLModel.event(i) = Event_moveNameToId(SBMLModel.event(i));
end;

