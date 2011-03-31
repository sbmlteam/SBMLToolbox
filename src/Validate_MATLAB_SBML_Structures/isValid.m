function y = isValid(sbml_struct)

typecode = sbml_struct.typecode;

switch (typecode)
  case 'SBML_ALGEBRAIC_RULE'
    fhandle = str2func('isSBML_AlgebraicRule');
  case 'SBML_ASSIGNMENT_RULE'
    fhandle = str2func('isSBML_AssignmentRule');
  case 'SBML_COMPARTMENT'
    fhandle = str2func('isSBML_Compartment');
  case 'SBML_COMPARTMENT_TYPE'
    fhandle = str2func('isSBML_CompartmentType');
  case 'SBML_COMPARTMENT_VOLUME_RULE'
    fhandle = str2func('isSBML_CompartmentVolumeRule');
  case 'SBML_CONSTRAINT'
    fhandle = str2func('isSBML_Constraint');
  case 'SBML_DELAY'
    fhandle = str2func('isSBML_Delay');
  case 'SBML_EVENT'
    fhandle = str2func('isSBML_Event');
  case 'SBML_EVENT_ASSIGNMENT'
    fhandle = str2func('isSBML_EventAssignment');
  case 'SBML_FUNCTION_DEFINITION'
    fhandle = str2func('isSBML_FunctionDefinition');
  case 'SBML_INITIAL_ASSIGNMENT'
    fhandle = str2func('isSBML_InitialAssignment');
  case 'SBML_KINETIC_LAW'
    fhandle = str2func('isSBML_KineticLaw');
  case 'SBML_LOCAL_PARAMETER'
    fhandle = str2func('isSBML_LocalParameter');
  case 'SBML_MODIFIER_SPECIES_REFERENCE'
    fhandle = str2func('isSBML_ModifierSpeciesReference');
  case 'SBML_PARAMETER'
    fhandle = str2func('isSBML_Parameter');
  case 'SBML_PARAMETER_RULE'
    fhandle = str2func('isSBML_ParameterRule');
  case 'SBML_PRIORITY'
    fhandle = str2func('isSBML_Priority');
  case 'SBML_RATE_RULE'
    fhandle = str2func('isSBML_RateRule');
  case 'SBML_REACTION'
    fhandle = str2func('isSBML_Reaction');
  case 'SBML_SPECIES'
    fhandle = str2func('isSBML_Species');
  case 'SBML_SPECIES_CONCENTRATION_RULE'
    fhandle = str2func('isSBML_SpeciesConcentrationRule');
  case 'SBML_SPECIES_REFERENCE'
    fhandle = str2func('isSBML_SpeciesReference');
  case 'SBML_SPECIES_TYPE'
    fhandle = str2func('isSBML_SpeciesType');
  case 'SBML_STOICHIOMETRY_MATH'
    fhandle = str2func('isSBML_StoichiometryMath');
  case 'SBML_TRIGGER'
    fhandle = str2func('isSBML_Trigger');
  case 'SBML_UNIT'
    fhandle = str2func('isSBML_Unit');
  case 'SBML_UNIT_DEFINITION'
    fhandle = str2func('isSBML_UnitDefinition');
  otherwise
    fhandle = str2func('isSBML_Model');
end;

 y = (feval(fhandle, sbml_struct, 1, 1) ...
   || feval(fhandle, sbml_struct, 1, 2) ...
   || feval(fhandle, sbml_struct, 2, 1) ...
   || feval(fhandle, sbml_struct, 2, 2) ...
   || feval(fhandle, sbml_struct, 2, 3) ...
   || feval(fhandle, sbml_struct, 2, 4) ...
   || feval(fhandle, sbml_struct, 3, 1)); 
