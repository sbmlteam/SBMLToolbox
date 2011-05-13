function [defaultValues] = getDefaultValues(typecode, level, version)
%
%   getDefaultValues
%             takes the typecode, level and version
%
%             and returns 
%               the default values for the MATLAB_SBML structure 
%

%  Filename    :   getDefaultValues.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id:  $
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



switch (typecode)
  case 'SBML_ALGEBRAIC_RULE'
    fhandle = str2func('getAlgebraicRuleDefaultValues');
  case 'SBML_ASSIGNMENT_RULE'
    fhandle = str2func('getAssignmentRuleDefaultValues');
  case 'SBML_COMPARTMENT'
    fhandle = str2func('getCompartmentDefaultValues');
  case 'SBML_COMPARTMENT_TYPE'
    fhandle = str2func('getCompartmentTypeDefaultValues');
  case 'SBML_COMPARTMENT_VOLUME_RULE'
    fhandle = str2func('getCompartmentVolumeRuleDefaultValues');
  case 'SBML_CONSTRAINT'
    fhandle = str2func('getConstraintDefaultValues');
  case 'SBML_DELAY'
    fhandle = str2func('getDelayDefaultValues');
  case 'SBML_EVENT'
    fhandle = str2func('getEventDefaultValues');
  case 'SBML_EVENT_ASSIGNMENT'
    fhandle = str2func('getEventAssignmentDefaultValues');
  case 'SBML_FUNCTION_DEFINITION'
    fhandle = str2func('getFunctionDefinitionDefaultValues');
  case 'SBML_INITIAL_ASSIGNMENT'
    fhandle = str2func('getInitialAssignmentDefaultValues');
  case 'SBML_KINETIC_LAW'
    fhandle = str2func('getKineticLawDefaultValues');
  case 'SBML_LOCAL_PARAMETER'
    fhandle = str2func('getLocalParameterDefaultValues');
  case 'SBML_MODEL'
    fhandle = str2func('getModelDefaultValues');
  case 'SBML_MODIFIER_SPECIES_REFERENCE'
    fhandle = str2func('getModifierSpeciesReferenceDefaultValues');
  case 'SBML_PARAMETER'
    fhandle = str2func('getParameterDefaultValues');
  case 'SBML_PARAMETER_RULE'
    fhandle = str2func('getParameterRuleDefaultValues');
  case 'SBML_PRIORITY'
    fhandle = str2func('getPriorityDefaultValues');
  case 'SBML_RATE_RULE'
    fhandle = str2func('getRateRuleDefaultValues');
  case 'SBML_REACTION'
    fhandle = str2func('getReactionDefaultValues');
  case 'SBML_SPECIES'
    fhandle = str2func('getSpeciesDefaultValues');
  case 'SBML_SPECIES_CONCENTRATION_RULE'
    fhandle = str2func('getSpeciesConcentrationRuleDefaultValues');
  case 'SBML_SPECIES_REFERENCE'
    fhandle = str2func('getSpeciesReferenceDefaultValues');
  case 'SBML_SPECIES_TYPE'
    fhandle = str2func('getSpeciesTypeDefaultValues');
  case 'SBML_STOICHIOMETRY_MATH'
    fhandle = str2func('getStoichiometryMathDefaultValues');
  case 'SBML_TRIGGER'
    fhandle = str2func('getTriggerDefaultValues');
  case 'SBML_UNIT'
    fhandle = str2func('getUnitDefaultValues');
  case 'SBML_UNIT_DEFINITION'
    fhandle = str2func('getUnitDefinitionDefaultValues');
  otherwise
    error('%s\n%s', ...
      'getDefaultValues(typecode, level, version', ...
      'typecode not recognised');    
end;

[defaultValues] = feval(fhandle, level, version);
