function y = TestCreate()

fail = 0;
numTests = 0;

level = 1;
version = 1;
for (level = 1:2)
  obj = AlgebraicRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AlgebraicRule(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = AlgebraicRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AlgebraicRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = AssignmentRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AssignmentRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Compartment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Compartment(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Compartment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Compartment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 2;
for (version = 2:3)
  obj = CompartmentType_create(level, version);
  numTests = numTests+1;
  if (~isSBML_CompartmentType(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:1)
  obj = CompartmentVolumeRule_create();
  numTests = numTests+1;
  if (~isSBML_CompartmentVolumeRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 2:3)
  obj = Constraint_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Constraint(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = Event_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Event(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = EventAssignment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_EventAssignment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = FunctionDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_FunctionDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 2;
for (version = 2:3)
  obj = InitialAssignment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_InitialAssignment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = KineticLaw_create(level, version);
  numTests = numTests+1;
  if (~isSBML_KineticLaw(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = KineticLaw_create(level, version);
  numTests = numTests+1;
  if (~isSBML_KineticLaw(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = ModifierSpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_ModifierSpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Parameter_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Parameter(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Parameter_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Parameter(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:1)
  obj = ParameterRule_create();
  numTests = numTests+1;
  if (~isSBML_ParameterRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 1;
for (version = 1:3)
  obj = RateRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_RateRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Reaction_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Reaction(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Reaction_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Reaction(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Species_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Species(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Species_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Species(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:1)
  obj = SpeciesConcentrationRule_create();
  numTests = numTests+1;
  if (~isSBML_SpeciesConcentrationRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = SpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = SpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
version = 2;
for (version = 2:3)
  obj = SpeciesType_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesType(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Unit_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Unit(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Unit_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Unit(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = UnitDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_UnitDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = UnitDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_UnitDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
version = 1;
for (level = 1:2)
  obj = Model_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Model(obj))
    fail = fail + 1;
  end;
end;
for (version = 2:3)
  obj = Model_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Model(obj))
    fail = fail + 1;
  end;
end;


disp(sprintf('Number tests: %d', numTests));
disp(sprintf('Number fails: %d', fail));
disp(sprintf('Pass rate: %d%%', ((numTests-fail)/numTests)*100));

y = fail;

