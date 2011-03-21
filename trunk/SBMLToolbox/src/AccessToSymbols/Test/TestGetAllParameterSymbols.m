function fail = TestGetAllParameterSymbols
% GetAllParameterSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value -1 is used
%--------------------------------------------------------------------------


%  Filename    :   TestGetAllParameterSymbols.m
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

m = TranslateSBML('../../Test/test-data/l1v1.xml');

syms k_1 k_2 vm km;

x = [vm, km, k_1, k_2];

y = [2, 2, 1, 0];

z = {'vm', 'km', 'k_1', 'k_2'};

fail = TestFunction('GetAllParameterSymbols',1, 3, m, x, y, z);
