function fail = TestGetSymbolicParameterInitialAssignments
% GetSymbolicParameterInitialAssignment takes an SBMLModel 
% and returns
%             1) an array of parameter symbols
%             2) an array of the symbolic representation of the
%             initial assignment for each parameter assigned by an
%             initialAssignment

%  Filename    :   TestGetSymbolicParameterInitialAssignments.m
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


% m = TranslateSBML('../../Test/test-data/initialAssignments.xml');
% 
% syms k k1 s1 s2 s3 c c1;
% 
% parameter = [k k1 s1 s2 s3 c c1];
% initial = {[s1*k1/s3], [sym('0')], [sym('0')], [sym('0')], [sym('0')], ...
%                                               [sym('0')], [sym('0')] };
% 
% fail = TestFunction('GetSymbolicParameterInitialAssignments', 1, 2, m, parameter, initial);

m = TranslateSBML('../../Test/test-data/funcDefsWithInitialAssignments.xml');

syms k k1 s1 s2 s3 c c1;

parameter = [k k1 s1 s2 s3 c c1];
initial = {[s1*k1/s3], [sym('0')], [sym('0')], [sym('0')], [sym('0')], ...
                                              [sym('0')], [sym('0')] };

fail = TestFunction('GetSymbolicParameterInitialAssignments', 1, 2, m, parameter, initial);
