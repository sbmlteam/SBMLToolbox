function fail = TestSubstitute
% Substitute 
%       takes 
%           1) a string representation of a formula 
%           2) the SBMLModel structure
%       and returns 
%           the value calculated when all variables are substituted
%
%
%   EXAMPLE:
%           m = SBMLModel with species
%               with id = 'g' and initialConcentration = 3' 
%
%           value = Substitute('g*2', m)
%           
%                   = 6


%  Filename    :   TestSubstitute.m
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


m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

formula = 'S1*2';

fail = TestFunction('Substitute', 2, 1, formula, m, 6);


m = TranslateSBML('../../Test/test-data/l1v1.xml');

formula = '(x0 + vm) * (km*2)';


fail = fail + TestFunction('Substitute', 2, 1, formula, m, 12);

