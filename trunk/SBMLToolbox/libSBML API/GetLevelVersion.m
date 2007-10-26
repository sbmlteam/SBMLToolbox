function [level, version] = GetLevelVersion(SBMLStructure)
%
%   GetLevelVersion 
%             takes an SBMLStructure
%
%             and returns 
%               the sbml level and version 
%
%       [level, version] = GetLevelVersion(SBMLStructure)


%  Filename    :   Compartment_create.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):

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

while (version < 4)
  if (feval(fhandle, SBMLStructure, level, version))
    break;
  else
    version = version + 1;
  end;
end;

if (version == 4)
  level = 0;
  version = 0;
end;


