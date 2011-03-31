function level = GetLevel(SBMLStructure)
%
%   GetLevel
%             takes an SBMLStructure
%
%             and returns 
%               the sbml level 
%
%       level = GetLevel(SBMLStructure)

%  Filename    :   GetLevel.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: GetLevelVersion.m 13259 2011-03-21 05:40:36Z mhucka $
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



% check that input is correct
if (~isValid(SBMLStructure))
    error(sprintf('%s\n%s', ...
      'GetLevel(SBMLStructure)', ...
      'argument must be an SBML structure'));
end;
 

typecode = SBMLStructure.typecode;

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
  case 'SBML_MODEL'
    level = SBMLStructure.SBML_Level;
    return;
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
    error(sprintf('%s\n%s', ...
      'GetLevel(SBMLStructure)', ...
      'argument must be an SBML structure'));    
end;

   
level = 1;
version = 1;

if (~feval(fhandle, SBMLStructure, level))
  level = 2;
  version = 1;
end;

while (version < 5)
  if (feval(fhandle, SBMLStructure, level, version))
    return;
  else
    version = version + 1;
  end;
end;

level = 3;
version = 1;
if (feval(fhandle, SBMLStructure, level, version))
  return;
else
  error(sprintf('%s\n%s', ...
      'GetLevel(SBMLStructure)', ...
      'cannot determine the level'));    
end;


