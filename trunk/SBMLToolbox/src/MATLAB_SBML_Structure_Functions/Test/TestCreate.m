function y = TestCreate()

%  Filename    :   TestCreate.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

fail = 0;
numTests = 0;

level = 1;
for version = 1:2
  obj = AlgebraicRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AlgebraicRule(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = AlgebraicRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AlgebraicRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = AssignmentRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_AssignmentRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Compartment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Compartment(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Compartment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Compartment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 2:4
  obj = CompartmentType_create(level, version);
  numTests = numTests+1;
  if (~isSBML_CompartmentType(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = CompartmentVolumeRule_create();
  numTests = numTests+1;
  if (~isSBML_CompartmentVolumeRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 2:4
  obj = Constraint_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Constraint(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = Event_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Event(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = EventAssignment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_EventAssignment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = FunctionDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_FunctionDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 2:4
  obj = InitialAssignment_create(level, version);
  numTests = numTests+1;
  if (~isSBML_InitialAssignment(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = KineticLaw_create(level, version);
  numTests = numTests+1;
  if (~isSBML_KineticLaw(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = KineticLaw_create(level, version);
  numTests = numTests+1;
  if (~isSBML_KineticLaw(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = ModifierSpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_ModifierSpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Parameter_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Parameter(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Parameter_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Parameter(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = ParameterRule_create();
  numTests = numTests+1;
  if (~isSBML_ParameterRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 1:4
  obj = RateRule_create(level, version);
  numTests = numTests+1;
  if (~isSBML_RateRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Reaction_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Reaction(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Reaction_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Reaction(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Species_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Species(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Species_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Species(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = SpeciesConcentrationRule_create();
  numTests = numTests+1;
  if (~isSBML_SpeciesConcentrationRule(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = SpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = SpeciesReference_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesReference(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 2:4
  obj = SpeciesType_create(level, version);
  numTests = numTests+1;
  if (~isSBML_SpeciesType(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Unit_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Unit(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Unit_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Unit(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = UnitDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_UnitDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = UnitDefinition_create(level, version);
  numTests = numTests+1;
  if (~isSBML_UnitDefinition(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 1;
for version = 1:2
  obj = Model_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Model(obj))
    fail = fail + 1;
  end;
end;
level = 2;
for version = 1:4
  obj = Model_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Model(obj))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 3:4
  obj = Delay_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Delay(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 3:4
  obj = StoichiometryMath_create(level, version);
  numTests = numTests+1;
  if (~isSBML_StoichiometryMath(obj, level, version))
    fail = fail + 1;
  end;
end;

level = 2;
for version = 3:4
  obj = Trigger_create(level, version);
  numTests = numTests+1;
  if (~isSBML_Trigger(obj, level, version))
    fail = fail + 1;
  end;
end;

disp(sprintf('Number tests: %d', numTests));
disp(sprintf('Number fails: %d', fail));
disp(sprintf('Pass rate: %d%%', ((numTests-fail)/numTests)*100));

y = fail;

