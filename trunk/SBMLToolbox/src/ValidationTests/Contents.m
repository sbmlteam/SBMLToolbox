% SBMLToolbox\ValidationTests
% 
% isSBML_XXX(SBMLStructure, Level)
% Functions that return TRUE if SBMLStructure is a structure of type XXX
% FALSE if SBMLStructure is 
%                           NOT a structure
%                    OR     does not contain the appropriate fields to be of
%                           type XXX and Level of SBML
%                    OR     does not have the correct Typecode string
%
% Functions include
%
% isSBML_Model(SBMLStructure) 
%   identifies the level from the model structure
%
% isSBML_AlgebraicRule(SBMLStructure, Level)
% isSBML_AssignmentRule(SBMLStructure, Level)
% isSBML_Compartment(SBMLStructure, Level) 
% isSBML_CompartmentVolumeRule(SBMLStructure, Level)
% isSBML_Event(SBMLStructure, Level) 
% isSBML_EventAssignment(SBMLStructure, Level) 
% isSBML_FunctionDefinition(SBMLStructure, Level) 
% isSBML_KineticLaw(SBMLStructure, Level) 
% isSBML_ModifierSpeciesReference(SBMLStructure, Level) 
% isSBML_Parameter(SBMLStructure, Level) 
% isSBML_ParameterRule(SBMLStructure, Level)
% isSBML_Reaction(SBMLStructure, Level) 
% isSBML_Rule(SBMLStructure, Level) 
% isSBML_Species(SBMLStructure, Level) 
% isSBML_SpeciesConcentrationRule(SBMLStructure, Level) 
% isSBML_SpeciesReference(SBMLStructure, Level) 
% isSBML_Unit(SBMLStructure, Level) 
% isSBML_UnitDefinition(SBMLStructure, Level) 

%
%  Description : This is the directory for the functions  
%				 to validate the MATLAB structures as components of an sbml model 
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-09-15
%  Revision    : $Id$
%  Source      : $Source$
%
%  Copyright 2003 California Institute of Technology, the Japan Science
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
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%
