function fail = TestcharFormula2sym
% charFormula2sym converts a character representation of a mathematical formula
% to a symbolic representation of that formula
%
% returns 
%     1) the symbolic representation of the formula as first output argument
%     2) an array of the symbols used within the formula as second output
%     argument
%
%-------------------------------------------------------------------------
% EXAMPLE:  [y, z] = charFormula2sym('2 * (a^2) + (3 * b) + c')
%           y = 2*a^2+3*b+c
%           z = [a, b, c]


%  Filename    :   TestcharFormula2sym.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
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


formula = '2 * (a^2) + (3 * b) + c';

syms a b c;

y = 2*a^2+3*b+c;
z = [a, b, c];

fail = TestFunction('charFormula2sym', 1,2, formula, y, z);
