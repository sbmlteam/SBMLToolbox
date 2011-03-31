function [level, version] = GetLevelVersion(SBMLStructure)
%
%   GetLevelVersion 
%             takes an SBMLStructure
%
%             and returns 
%               the sbml level and version 
%
%       [level, version] = GetLevelVersion(SBMLStructure)

%  Filename    :   GetLevelVersion.m
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



% check that input is correct
if (~isstruct(SBMLStructure))
    error(sprintf('%s\n%s', ...
      'GetLevelVersion(SBMLStructure)', ...
      'argument must be an SBML structure'));
end;
 

typecode = SBMLStructure.typecode;

switch (typecode)
  case 'SBML_COMPARTMENT'
    func = 'isSBML_Compartment';
    fhandle =  str2func(func);
  case 'SBML_EVENT'
    func = 'isSBML_Event';
    fhandle =  str2func(func);
  case 'SBML_EVENT_ASSIGNMENT'
    func = 'isSBML_EventAssignment';
    fhandle =  str2func(func);
  case 'SBML_FUNCTION_DEFINITION'
    func = 'isSBML_FunctionDefinition';
    fhandle =  str2func(func);
  case 'SBML_KINETIC_LAW'
    func = 'isSBML_KineticLaw';
    fhandle =  str2func(func);
  case 'SBML_MODEL'
    level = SBMLStructure.SBML_level;
    version = SBMLStructure.SBML_version;
    return;
  case 'SBML_PARAMETER'
    func = 'isSBML_Parameter';
    fhandle =  str2func(func);
  case 'SBML_REACTION'
    func = 'isSBML_Reaction';
    fhandle =  str2func(func);
  case 'SBML_SPECIES'
    func = 'isSBML_Species';
    fhandle =  str2func(func);
  case 'SBML_SPECIES_REFERENCE'
    func = 'isSBML_SpeciesReference';
    fhandle =  str2func(func);
  case 'SBML_MODIFIER_SPECIES_REFERENCE'
    func = 'isSBML_ModifierSpeciesReference';
    fhandle =  str2func(func);
  case 'SBML_UNIT_DEFINITION'
    func = 'isSBML_UnitDefinition';
    fhandle =  str2func(func);
  case 'SBML_UNIT'
    func = 'isSBML_Unit';
    fhandle =  str2func(func);
  case 'SBML_ASSIGNMENT_RULE'
    func = 'isSBML_AssignmentRule';
    fhandle =  str2func(func);
  case 'SBML_ALGEBRAIC_RULE'
    func = 'isSBML_AlgebraicRule';
    fhandle =  str2func(func);
  case 'SBML_RATE_RULE'
    func = 'isSBML_RateRule';
    fhandle =  str2func(func);
  case 'SBML_SPECIES_CONCENTRATION_RULE'
    func = 'isSBML_SpeciesConcentrationRule';
    fhandle =  str2func(func);
  case 'SBML_COMPARTMENT_VOLUME_RULE'
    func = 'isSBML_CompartmentVolumeRule';
    fhandle =  str2func(func);
  case 'SBML_PARAMETER_RULE'
    func = 'isSBML_ParameterRule';
    fhandle =  str2func(func);
  case 'SBML_CONSTRAINT'
    func = 'isSBML_Constraint';
    fhandle =  str2func(func);
  case 'SBML_INITIAL_ASSIGNMENT'
    func = 'isSBML_InitialAssignment';
    fhandle =  str2func(func);
  case 'SBML_COMPARTMENT_TYPE'
    func = 'isSBML_CompartmentType';
    fhandle =  str2func(func);
  case 'SBML_SPECIES_TYPE'
    func = 'isSBML_SpeciesType';
    fhandle =  str2func(func);
  otherwise
    error(sprintf('%s\n%s', ...
      'GetLevelVersion(SBMLStructure)', ...
      'argument must be an SBML structure'));    
end;

    
level = 1;
version = 2;

if (~feval(fhandle, SBMLStructure, level))
  level = 2;
  version = 1;
end;

while (version < 5)
  if (feval(fhandle, SBMLStructure, level, version))
    break;
  else
    version = version + 1;
  end;
end;

if (version == 5)
  level = 3;
  version = 1;
end;


