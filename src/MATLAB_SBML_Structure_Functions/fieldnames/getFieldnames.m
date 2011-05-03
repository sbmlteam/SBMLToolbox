function [SBMLfieldnames, nNumberFields] = getFieldnames(typecode, ...
                                                         level, version)
%
%   getFieldnames
%             takes the typecode, level and version
%
%             and returns 
%               the fieldnames for the MATLAB_SBML structure 
%

%  Filename    :   getFieldnames.m
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
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_ASSIGNMENT_RULE'
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_COMPARTMENT'
    fhandle = str2func('getCompartmentFieldnames');
  case 'SBML_COMPARTMENT_TYPE'
    fhandle = str2func('getCompartmentTypeFieldnames');
  case 'SBML_COMPARTMENT_VOLUME_RULE'
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_CONSTRAINT'
    fhandle = str2func('getConstraintFieldnames');
  case 'SBML_DELAY'
    fhandle = str2func('getDelayFieldnames');
  case 'SBML_EVENT'
    fhandle = str2func('getEventFieldnames');
  case 'SBML_EVENT_ASSIGNMENT'
    fhandle = str2func('getEventAssignmentFieldnames');
  case 'SBML_FUNCTION_DEFINITION'
    fhandle = str2func('getFunctionDefinitionFieldnames');
  case 'SBML_INITIAL_ASSIGNMENT'
    fhandle = str2func('getInitialAssignmentFieldnames');
  case 'SBML_KINETIC_LAW'
    fhandle = str2func('getKineticLawFieldnames');
  case 'SBML_LOCAL_PARAMETER'
    fhandle = str2func('getLocalParameterFieldnames');
  case 'SBML_MODEL'
    fhandle = str2func('getModelFieldnames');
  case 'SBML_MODIFIER_SPECIES_REFERENCE'
    fhandle = str2func('getModifierSpeciesReferenceFieldnames');
  case 'SBML_PARAMETER'
    fhandle = str2func('getParameterFieldnames');
  case 'SBML_PARAMETER_RULE'
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_PRIORITY'
    fhandle = str2func('getPriorityFieldnames');
  case 'SBML_RATE_RULE'
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_REACTION'
    fhandle = str2func('getReactionFieldnames');
  case 'SBML_SPECIES'
    fhandle = str2func('getSpeciesFieldnames');
  case 'SBML_SPECIES_CONCENTRATION_RULE'
    fhandle = str2func('getRuleFieldnames');
  case 'SBML_SPECIES_REFERENCE'
    fhandle = str2func('getSpeciesReferenceFieldnames');
  case 'SBML_SPECIES_TYPE'
    fhandle = str2func('getSpeciesTypeFieldnames');
  case 'SBML_STOICHIOMETRY_MATH'
    fhandle = str2func('getStoichiometryMathFieldnames');
  case 'SBML_TRIGGER'
    fhandle = str2func('getTriggerFieldnames');
  case 'SBML_UNIT'
    fhandle = str2func('getUnitFieldnames');
  case 'SBML_UNIT_DEFINITION'
    fhandle = str2func('getUnitDefinitionFieldnames');
  otherwise
    error('%s\n%s', ...
      'getFieldnames(typecode, level, version', ...
      'typecode not recognised');    
end;

[SBMLfieldnames, nNumberFields] = feval(fhandle, level, version);
