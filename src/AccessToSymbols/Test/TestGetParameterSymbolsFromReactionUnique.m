function fail = TestGetParameterSymbolsFromReactionUnique
% GetParameterSymbolsFromReactionUnique takes a SBMLReaction 
% and returns 
%           1) an array of symbols representing all parameters defined 
%               within the kinetic law of the reaction with the reaction
%               name appended
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols


%  Filename    :   TestGetParameterSymbolsFromReactionUnique.m
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
r = m.reaction(2);

syms k_R2;
symbols = [k_R2];
names = {'k_R2'};
values = 0.1;

fail = TestFunction('GetParameterSymbolsFromReactionUnique', 1, 3, r, symbols, values, names);
