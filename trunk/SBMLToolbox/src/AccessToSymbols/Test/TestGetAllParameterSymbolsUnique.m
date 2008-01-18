function fail = TestGetAllParameterSymbolsUnique
% GetAllParameterSymbolsUnique takes an SBMLModel 
% and returns 
%           1) an array of symbols representing all parameters (both global
%           and embedded) within the model with reaction names appended
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%
% NOTE: if the values are not set then the value NaN is used
%--------------------------------------------------------------------------


%  Filename    :   TestGetAllParameterSymbolsUnique.m
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

syms k_1_R1 k_2_R2 vm km;

x = [vm km k_1_R1, k_2_R2];

y = [2, 2, 1, 0];

z = {'vm', 'km', 'k_1_R1', 'k_2_R2'};

fail = TestFunction('GetAllParameterSymbolsUnique', 1, 3, m, x, y, z);
