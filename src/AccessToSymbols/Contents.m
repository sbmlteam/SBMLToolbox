% toolbox\AccessToSymbols
%
% This directory provides functions that allow access to the Symbolic Math Toolbox
% 
% FUNCTIONS INCLUDE:
% 
% AnalyseSpeciesSymbolic 
%       takes an SBMLmodel 
%       and returns
%           structure detailing the species and how they are manipulated within the model
%
% charFormula2sym
%       takes a characater representation of a mathematical formula
%       and returns 
%           1) the symbolic representation of the formula 
%           2) an array of the symbols used within the formula 
% 
% CreateSymArray
%       takes any symbolic expression or set of symbolic expressions
%       and returns 
%           an array of the single symbolic expressions found in the input 
%
% GetAllParameterSymbols 
%       takes an SBMLModel 
%       and returns 
%       1) an array of symbols representing all parameters (both global and embedded) within the model 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetAllParameterSymbolsUnique 
%       takes an SBMLModel 
%       and returns 
%       1) an array of symbols representing all parameters 
%           (both global and embedded) within the model with reaction names appended 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetCompartmentSymbols 
%       takes an SBMLModel 
%       and returns 
%           1) an array of symbols representing all compartments within the model 
%           2) an array of the volume/size values of each compartment
%           3) an array of character names of the symbols
%
% GetCompartmentTypeSymbols 
%       takes an SBMLModel 
%       and returns 
%           1) an array of symbols representing all compartmentTypes within the model 
%           2) an array of character names of the symbols
%
% GetDegree
%       takes a symbolic polynomial and a single symbol
%       and returns 
%           the degree of the symbol in the polynomial
%
% GetEquilibrium 
%       takes an SBMLModel 
%       and returns 
%           1) an array representing the equilibrium values of each species 
%           2) a structure containing other equilibrium conditions
%
% GetGlobalParameterSymbols 
%       takes an SBMLModel 
%       and returns 
%           1) an array of symbols representing all global parameters within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
% 
% GetParameterSymbolsFromReaction 
%       takes an SBMLReaction 
%       and returns 
%           1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
% 
% GetParameterSymbolsFromReactionUnique 
%       takes an SBMLReaction 
%       and returns 
%           1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction with reaction names appended
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
% 
% GetSpeciesSymbols 
%       takes an SBMLModel 
%       and returns 
%           1) an array of symbols representing all species within the model 
%           2) an array of the initial concentration/amount values of each species
%           3) an array of character names of the symbols
% 
% GetSpeciesTypeSymbols 
%       takes an SBMLModel 
%       and returns 
%           1) an array of symbols representing all speciesTypes within the model 
%           2) an array of character names of the symbols
%
% GetStoichiometryMatrixSyms 
%       takes an SBML model 
%       and returns 
%           1) stoichiometry matrix
%           2) an array of symbols respresenting each species in same order
%               as the stoichiometry matrix treats them
%
% GetSymbolicCompartmentInitialAssignment 
%       takes an SBMLModel 
%       and returns
%             1) an array of compartment symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each compartment assigned by an
%             initialAssignment
%
% GetSymbolicParameterInitialAssignment 
%       takes an SBMLModel 
%       and returns
%             1) an array of parameter symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each parameter assigned by an
%             initialAssignment
%
% GetSymbolicRateLawsFromReactions 
%       takes an SBML model 
%       and returns 
%           1)array of species symbols
%           2)an array of symbolic representations of the rate law for each species
%               from rules
%
% GetSymbolicRateLawsFromRules 
%       takes an SBMLModel 
%       and returns 
%           1)array of species symbols
%           2)an array of symbolic representations of the rate law for each species
%
% GetSymbolicSpeciesAlgebraicRules 
%       takes an SBMLModel 
%       and returns
%           1) an array of species symbols
%           2) an array of the symbolic representation of each algebraic
%             rule the species appears in
%
% GetSymbolicSpeciesAssignmentRules 
%       takes an SBMLModel 
%       and returns
%             1) an array of species symbols
%             2) an array of the symbolic representation of the
%             assignment for each species assigned by rules
%
% GetSymbolicSpeciesInitialAssignment 
%       takes an SBMLModel 
%       and returns
%             1) an array of species symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each species assigned by an
%             initialAssignment
%
% PlotSelectedTimeCourse takes
%       1) an SBMLModel
%       2) time limit (optional)
%       3) number of time steps (optional)
%
%       plots the time course of user selected species to equilibrium
% 
%       and returns
%           1) the value of each species at the time limit (optional)
%
% PlotTimeCourse takes 
%       1) an SBMLModel
%       2) time limit (optional)
%       3) number of time steps (optional)
%       4) a flag to indicate whther to output the data as a CSV (optional)
%
%       plots the time course of each species
% 
%       and returns
%           1) the value of each species at the time limit (optional)


%
%  Filename    : Contents.m
%  Description : This directory contains the functions that allow the user
%               to access the symbolic math toolbox
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
