% toolbox\AccessModel
%
%  This directory contains functions that allow the user to
%               derive information from a SBML Model
%
% CheckValues 
%       takes an SBMLModel
%           provides a GUI that allows the user to view and/or edit the values
%           for the initial concentration of species and parameter values
%       and returns
%           1) an array of values for the initial concentration of the species
%           2) an array of values for the parameters
%
% DetermineSpeciesRoleInReaction
%       takes an SBML species and  reaction
%       and determines where the species takes part in the reaction
%       (see function help for more detail)
%
%
% GetAllParameters 
%       takes an SBMLModel 
%       and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%
% GetAllParametersUnique 
%       takes an SBMLModel 
%       and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%               (with reaction names appended)
%           2) an array of the values of each parameter
%
% GetCompartments 
%       takes an SBMLModel 
%       and returns 
%           1) an array of character names of all compartments within the model 
%           2) an array of the size/volume values of each compartment
%
%
% GetGlobalParameters 
%       takes an SBMLModel 
%       and returns 
%           1) an array of character names representing all global parameters within the model 
%           2) an array of the values of each parameter
%
% GetParameterFromReaction 
%       takes an SBMLReaction 
%       and returns 
%           1) an array of character names representing all parameters defined 
%               within the kinetic law of the reaction 
%           2) an array of the values of each parameter
%
% GetParameterFromReactionUnique
%       takes an SBMLReaction 
%       and returns 
%           1) an array of character names representing all parameters defined 
%               within the kinetic law of the reaction 
%               (with reaction names appended)
%           2) an array of the values of each parameter
%
% GetRateLawsFromReactions 
%       takes an SBMLModel 
%       and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species
%
% GetRateLawsFromRules 
%       takes an SBMLModel 
%       and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species from rules
%
% GetSpecies 
%       takes an SBMLModel 
%       and returns 
%           1) an array of character names of all species within the model 
%           2) an array of the initial concentration values of each species
%
% GetSpeciesAlgebraicRules 
%       takes an SBMLModel 
%       and returns
%             1) an array of species names
%             2) an array of the character representation of each algebraic
%             rule the species appears in
%
% GetSpeciesAssignmentRules 
%       takes an SBMLModel 
%       and returns
%             1) an array of species names
%             2) an array of the character representation of the
%             concentration for each species assigned by rules
%
% GetStoichiometryMatrix 
%       takes an SBML model 
%       and returns 
%           1) stoichiometry matrix
%           2) an array of character names of all species within the model 
%
% IsSpeciesInReaction
%       takes an SBML species and an SBML reaction
%       and determines where the species takes part in the reaction


%  Filename    : Contents.m
%  Description : This directory contains functions that allow the user to
%               derive information from a SBML Model
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
%  Revision    : $Id$
%  Source      : $Source $
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
