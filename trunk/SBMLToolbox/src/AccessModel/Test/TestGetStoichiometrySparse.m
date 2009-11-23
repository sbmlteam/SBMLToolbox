function fail = TestGetStoichiometrySparse
% GetStoichiometryMatrix(SBMLModel) takes an SBML model 
% returns 
%       1) stoichiometry matrix
%       2) an array of character names of all species within the model 


%  Filename    :   TestGetStoichiometryMatrix.m
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

matrix = [-1, 0; 1, -1; 0, 1; 0, 0];

fail = TestFunction('GetStoichiometrySparse', 1, 1, m, matrix);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

matrix = [-1, 0; 1, -1; 0, 1; 0, 0];

fail = TestFunction('GetStoichiometrySparse', 1, 1, m, matrix);

m = TranslateSBML('../../Test/test-data/sparseStoichiometry.xml');

matrix = sparse(zeros(12,4));
matrix(1,1) = -1;
matrix(2,2) = -1;
matrix(11,3) = -1;
matrix(5,4) = -1;
matrix(2,1) = 1;
matrix(3,2) = 1;
matrix(12,3) = 1;
matrix(6,4) = 1;

fail = TestFunction('GetStoichiometrySparse', 1, 1, m, matrix);

