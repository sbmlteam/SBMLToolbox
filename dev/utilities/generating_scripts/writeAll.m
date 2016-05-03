function writeAll

Objects = {'AlgebraicRule', 'AssignmentRule', 'Compartment',  'CompartmentType', ...
   'CompartmentVolumeRule',  'Constraint',  'Delay', 'Event', 'EventAssignment', ...
    'FunctionDefinition', 'InitialAssignment', 'KineticLaw', 'LocalParameter', ...
     'Model', 'ModifierSpeciesReference', 'Parameter', 'ParameterRule', ...
      'Priority', 'RateRule', 'Reaction', 'Species', 'SpeciesConcentrationRule', ...
       'SpeciesReference', 'SpeciesType', 'StoichiometryMath', 'Trigger', ...
        'Unit', 'UnitDefinition'};
    
Fbc_objects= {'FluxBound', 'Objective', 'FluxObjective', 'GeneProduct', 'GeneProductAssociation', ...
    'FBCModel', 'FBCSpecies', 'FBCReaction', 'Association'};

for i=1:length(Fbc_objects)
  cd (Fbc_objects{i});
  writeStruct(Fbc_objects{i});
  cd ..
end;

% for i = 1:length(Fbc_objects)
%     writeCreate(Fbc_objects{i});
% end;
