function fail = TestGetSpecies
% GetSpecies takes a SBMLModel 
% and returns 
%           1) an array of character names of all species within the model 
%           2) an array of the initial concentration values of each species
%


%  Filename    :   TestGetSpecies.m
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

names = {'S1', 'S2', 'x0'};
values = [1.5e-15, 1.45, 1];

fail = TestFunction('GetSpecies', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

names = {'S1', 'S2', 'S3', 'X', 'S4'};
values = [3, 6, 7, 9, 0];

fail = fail + TestFunction('GetSpecies', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/funcDefsWithInitialAssignments.xml');

names = {'S1', 'S2', 'S3', 'X', 'S4'};
values = [3, 6, 0, 9, 0];

fail = fail + TestFunction('GetSpecies', 1, 2, m, names, values);