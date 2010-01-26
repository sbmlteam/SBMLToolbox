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
% GetCompartmentTypes 
%       takes a SBMLModel 
%       and returns 
%           1) an array of character names of all compartmentTypes within the model 
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
% GetSpeciesTypes 
%       takes a SBMLModel 
%       and returns 
%           1) an array of character names of all speciesTypes within the model 
%
% GetStoichiometryMatrix 
%       takes an SBML model 
%       and returns 
%           1) stoichiometry matrix
%           2) an array of character names of all species within the model 
%
% GetStoichiometrySparse 
%       takes an SBML model 
%       and returns 
%           1) the sparse stoichiometry matrix
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
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->
