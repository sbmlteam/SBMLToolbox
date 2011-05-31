function fail = TestGetVaryingParameters
% GetAllParameters takes a SBMLModel 
% and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%


%  Filename    :   TestGetAllParameters.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id: TestGetAllParameters.m 7155 2008-06-26 20:24:00Z mhucka $
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

names = {'s2'};
values = [4];
fail = 0;
fail = TestFunction('GetVaryingParameters', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/functionDefinition.xml');

names = {'p', 'c', 'c1', 'x', 'x1', 't', 'k_s'};
values = [2, 3, 18, 3, 3, 3, 3  ];

fail = fail + TestFunction('GetVaryingParameters', 1, 2, m, names, values);

m = TranslateSBML('../../Test/test-data/l3v1core.xml');

names = {'p', 'p1', 'p2', 'p3'};
values = [2, 4, 4, 2 ];

fail = fail + TestFunction('GetVaryingParameters', 1, 2, m, names, values);

