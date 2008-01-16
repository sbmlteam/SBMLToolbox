function fail = TestGetGlobalParameters
% GetGlobalParameters takes a SBMLModel 
% and returns 
%           1) an array of character names representing all global parameters within the model 
%           2) an array of the values of each parameter
%


%  Filename    :   TestGetGlobalParameters.m
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

names = {'k', 's1', 's2'};
values = [1, 3, 4];

fail = TestFunction('GetGlobalParameters', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

names = {'k', 'k1', 's1', 's2', 's3', 'c', 'c1'};
values = [6, 2, 3, 4, 1, 6, 2];

fail = fail + TestFunction('GetGlobalParameters', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/funcDefsWithInitialAssignments.xml');

names = {'k', 'k1', 's1', 's2', 's3', 'c', 'c1'};
values = [6, 2, 3, 4, 1, 6, 2];

fail = fail + TestFunction('GetGlobalParameters', 1, 2, m, names, values);
