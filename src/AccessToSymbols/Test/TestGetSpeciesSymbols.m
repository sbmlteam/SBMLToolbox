function fail = TestGetSpeciesSymbols
% GetSpeciesSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all species within the model 
%           2) an array of the initial concentration values of each species
%           3) an array of character names of the symbols


%  Filename    :   TestGetSpeciesSymbols.m
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


m = TranslateSBML('../../Test/test-data/l1v1.xml');

syms S1 S2 S3 X x0 S4;

symbols = [S1, S2, x0];
names = {'S1', 'S2', 'x0'};
values = [1.5e-15, 1.45, 1];

fail = TestFunction('GetSpeciesSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

symbols = [S1, S2, S3, X, S4];
names = {'S1', 'S2', 'S3', 'X', 'S4'};
values = [3, 6, 0, 9, 0];

fail = fail + TestFunction('GetSpeciesSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/funcDefsWithInitialAssignments.xml');

symbols = [S1, S2, S3, X, S4];
names = {'S1', 'S2', 'S3', 'X', 'S4'};
values = [3, 6, 0, 9, 0];

fail = fail + TestFunction('GetSpeciesSymbols', 1, 3, m, symbols, values, names);
