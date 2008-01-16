function fail = TestIsSpeciesInReaction
% IsSpeciesInReaction(SBMLSpecies, SBMLReaction)takes an SBML species and  reaction
% and determines where the species takes part in the reaction
%
% returns   0   if species is NOT part of the reaction
% or        n   if the species is part of the reaction
%               where n is the number of times it occurs


%  Filename    :   TestIsSpeciesInReaction.m
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

r1 = m.reaction(1);

s1 = m.species(1);
s2 = m.species(3);

fail = TestFunction('IsSpeciesInReaction', 2, 1, s1, r1, 1);
fail = fail + TestFunction('IsSpeciesInReaction', 2, 1, s2, r1, 0);
