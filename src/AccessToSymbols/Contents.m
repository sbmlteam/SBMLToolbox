% toolbox\AccessToSymbols
%
% This directory provides functions that allow access to the Symbolic Math Toolbox
% 
% FUNCTIONS INCLUDE:
% 
% charFormula2sym
%     converts a characater representation of a mathematical formula
%   to a symbolic representation of that formula
%   and returns 
%       1) the symbolic representation of the formula as first output argument
%       2) an array of the symbols used within the formula as second output
%           argument
% 
% CreateSymArray
%    takes any symbolic expression or set of symbolic expressions
%   and returns an array of the single symbolic expressions found in the input 
%
% GetAllParameterSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all parameters (both global and embedded) within the model 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetAllParameterSymbolsUnique 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all parameters 
%           (both global and embedded) within the model with reaction names appended 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetDegree
%     takes a symbolic polynomial and a single symbol
%   and returns 
%       the degree of the symbol in the polynomial
%
% GetEquilibrium 
%     takes a SBMLModel 
%   and returns 
%       1) an array representing the equilibrium values of each species 
%       2) a structure containing other equilibrium conditions
%
% GetGlobalParameterSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all global parameters within the model 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetParameterSymbolsFromReaction 
%     takes a SBMLReaction 
%   and returns 
%       1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetParameterSymbolsFromReactionUnique 
%     takes a SBMLReaction 
%   and returns 
%       1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction with reaction names
%               appended
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetSpeciesRateLaws 
%     takes an SBML model 
%   and returns 
%       1) an array of species symbols
%       2) an array of symbolic representations of the rate law for each species
% 
% GetSpeciesSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all species within the model 
%       2) an array of the initial concentration values of each species
%       3) an array of character names of the symbols
% 
% GetStoichiometryMatrixSyms(SBMLModel) 
%     takes an SBML model 
%    and returns 
%        1) stoichiometry matrix
%        2) an array of symbols respresenting each species in same order
%           as the stoichiometry matrix treats them
%
% PlotSelectedTimeCourse  
%     takes an SBML model 
%    and plots the time course of user selected species to equilibrium
%
% PlotTimeCourse  
%     takes an SBML model 
%    and plots the time course of the species to equilibrium


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
% This directory provides functions that allow access to the Symbolic Math Toolbox
% 
% FUNCTIONS INCLUDE:
% 
% charFormula2sym
%     converts a characater representation of a mathematical formula
%   to a symbolic representation of that formula
%   and returns 
%       1) the symbolic representation of the formula as first output argument
%       2) an array of the symbols used within the formula as second output
%           argument
% 
% CreateSymArray
%    takes any symbolic expression or set of symbolic expressions
%   and returns an array of the single symbolic expressions found in the input 
%
% GetAllParameterSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all parameters (both global and embedded) within the model 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetDegree
%     takes a symbolic polynomial and a single symbol
%   and returns 
%       the degree of the symbol in the polynomial
%
% GetGlobalParameterSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all global parameters within the model 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetParameterSymbolsFromReaction 
%     takes a SBMLReaction 
%   and returns 
%       1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction 
%       2) an array of the values of each parameter
%       3) an array of character names of the symbols
% 
% GetSpeciesRateLaws 
%     takes an SBML model 
%   and returns 
%       1) an array of species symbols
%       2) an array of symbolic representations of the rate law for each species
% 
% GetSpeciesSymbols 
%     takes a SBMLModel 
%   and returns 
%       1) an array of symbols representing all species within the model 
%       2) an array of the initial concentration values of each species
%       3) an array of character names of the symbols
% 
% GetStoichiometryMatrixSyms(SBMLModel) 
%     takes an SBML model 
%    and returns 
%        1) stoichiometry matrix
%        2) an array of symbols respresenting each species in same order
%           as the stoichiometry matrix treats them
%
% IsSpeciesInReaction
%     takes a SBML species and  reaction and determines where the species takes part in the reaction
%   returns   0   if species is NOT part of the reaction
%   or        an array indicting whether the species is a product,
%                   reactant or modifier
% 
% RemoveDuplicates 
%     takes any array 
%     and returns it with any duplicates removed



