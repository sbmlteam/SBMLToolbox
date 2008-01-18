function fail = TestGetSymbolicSpeciesAssignmentRules
% GetSymbolicSpeciesAssignmentRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the
%             concentration for each species assigned by rules


%  Filename    :   TestGetSymbolicSpeciesAssignmentRules.m
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


m = TranslateSBML('../../Test/test-data/algebraicRules.xml');

syms S1 S2 S3 X S4 s1 s2;

species = [S1, S2, S3, X, S4];
rules = {[sym('')], [sym('')], [s1+s2], [sym('')], [sym('')]};

fail = TestFunction('GetSymbolicSpeciesAssignmentRules', 1, 2, m, species, rules);
