function fail = TestGetDegree
% GetDegree(symPoly, var) takes a symbolic polynomial and a single symbol
% and returns the degree of the symbol var in the symbolic polynomial symPoly
%
% -----------------------------------------------
% EXAMPLE: 
%   GetDegree(a1^2*bd*c^3, a1)  =   2
% 
%   GetDegree(a1^2*bd*c^3, c)   =   3
% 
%   GetDegree(a1^2*bd*c^3, bd)  =   1
%
%   GetDegree(a1^2*bd*c^3, x)   =   0
% -----------------------------------------------


%  Filename    :   TestGetDegree.m
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
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

fail = 0;
syms a1 c bd x;

formula = a1^2*bd*c^3;

fail = fail + TestFunction('GetDegree', 2, 1, formula, a1, 2);
fail = fail + TestFunction('GetDegree', 2, 1, formula, c, 3);
fail = fail + TestFunction('GetDegree', 2, 1, formula, bd, 1);
fail = fail + TestFunction('GetDegree', 2, 1, formula, x, 0);
fail = fail + TestFunction('GetDegree', 2, 1, a1^2, a1, 2);
