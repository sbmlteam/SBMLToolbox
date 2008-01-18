function fail = TestCreateSymArray
% CreateSymArray(Input) takes any symbolic expression or set of symbolic expressions
% and returns an array of the single symbolic expressions found in the input 
%
%----------------------------------------------------------------
% EXAMPLE: CreateSymArray(a1^2*bd*c^3)
%           =   [a1, bd, c]
%----------------------------------------------------------------


%  Filename    :   TestCreateSymArray.m
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


syms a1 bd c;

formula = a1^2*bd*c^3;

y = [a1, bd, c];

fail = TestFunction('CreateSymArray', 1, 1, formula, y);
