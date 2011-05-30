% toolbox\Convenience
%
% CheckValidUnitKind 
%       takes a string representing a unit kind 
%
%       and returns 
%           1 if it is valid 
%           0 otherwise
%
%    NOTE: This is identical to the function isValidUnitKind
%
%
% LoseWhiteSpace 
%       takes an array of characters 
%
%       and returns 
%           the array with any white space removed
%
%    EXAMPLE:
%          y = LoseWhiteSpace('     exa  mp le')
%
%          y = 'example'
%
%
% PairBrackets 
%       takes a string 
%
%       and returns 
%           an array of indices of each pair of brackets
%               ordered from the opening bracket index
%
%    EXAMPLE:
%          pairs = PairBrackets('(a+((b*c)/(a+b)))')
%
%          pairs = 
%                      1   17
%                      4   16
%                      5    9
%                      11  15
%
%
% Rearrange
%       takes 
%           1) a char array representing a formula
%           2) a char array representing a variable
%
%       and returns 
%           the formula rearranged in terms of x
%
%    EXAMPLE:    
%          output   =   Rearrange('X + Y - Z', 'X')
%
%          output   =   '-Y+Z'
%
%
% RemoveDuplicates 
%       takes any array 
%
%       and returns 
%           the array with any duplicates removed
%
%
% Substitute 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%
%       and returns 
%           the value calculated when all variables are substituted
%
%    EXAMPLE:
%          Consider m to be an SBMLModel containing a species with 
%                     id = 'g' and initialConcentration = '3' 
%
%          value = Substitute('g*2', m)
%           
%          value = 6
%
%
% SubstituteConstants 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%       and returns 
%           a string representing the formula with the ids of any constants
%           within the model substituted
%
%
%    EXAMPLE:
%          Consider m to be an SBMLModel containing a parameter
%               with id = 'g' and value = 3' 
%
%          subsFormula = SubstituteConstants('2 * g * S1', SBMLModel)
%           
%          subsFormula = '2 * 3 * S1'
%
%
% SubstituteFunction 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLFunctionDefinition structure defining the formula
%       and returns 
%           the formula with the function substituted
%       or  an empty string if the id of the functionDefinition is not in the
%           originalFormula
%
%
%    EXAMPLE:
%          Consider fD to be an SBMLFunctionDefinition 
%               with id = 'g' and math = 'lambda(x,x+0.5)' 
%
%          formula = SubstituteFormula('g(y)', fD)
%           
%          formula = 'y+0.5'
%
%    OR
%          formula = SubstituteFormula('h(y)', fD)
%           
%          formula = ''
%
%
% isIntegralNumber 
%       takes a number
%       and returns 
%           1 if it is an integer 
%           0 otherwise (maybe of MATLAB type double)
%
%    NOTE: MATLAB's 'isinteger' function only returns true if the number 
%       has been declared as an int; whereas the default type for numbers 
%       in MATLAB is double
%
%
% isValidUnitKind 
%       takes a string representing a unit kind 
%
%       and returns 
%           1 if it is valid 
%           0 otherwise
%
%    NOTE: This is identical to the function CheckValidUnitKind
%
%
% matchName
%       takes a math expression and the name of a variable
%
%       and returns
%           the index of the starting point of 'name' in the 'expression'
%
%    NOTE: This differs from the 'strfind' function in that it checks
%       that the name is used as a variable.
%
%    EXAMPLE:
%          y = matchName('f*g', 'g')
%
%          y = 3
%
%    OR
%          y = matchName('f*g_1', 'g')
%
%          y = 0
%
%
% testmember 
%       takes 
%           1) a value
%           2) an array of values 
%
%       and returns 
%           1 if value is a member of the array 
%           0 otherwise
% 
%    NOTE: this function is necessary for octave to emulate the MATLAB
%       functionality of the 'ismember' function
%
%


%  Filename    :   Contents.m
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


