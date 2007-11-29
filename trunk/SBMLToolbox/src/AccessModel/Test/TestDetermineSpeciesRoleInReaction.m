function fail = TestDetermineSpeciesRoleInReaction
% DetermineSpeciesRoleInReaction(SBMLSpecies, SBMLReaction)takes a SBML species and  reaction
% and determines where the species takes part in the reaction
%
% returns   0   if species is NOT part of the reaction
% or        an array indicting whether the species is a product,
%                   reactant or modifier
%           and recording the position in the list of products/reactants
%
%           [isProduct, isReactant, isModifier, positionInProductList,
%           positionInReactantList]
%
%--------------------------------------------------------------------------
% EXAMPLE:    y   =   DetermineSpeciesRoleInReaction(s, r)
%                 =   0                 if s is not in r
%                 =   [1, 0, 0, 2, 0]   if s is product no 2 in r 
%                 =   [0, 1, 0, 0, 1]   if s is reactant no 1 in r
%                 =   [0, 0, 1, 0, 0]   if s is a modifier in r
%--------------------------------------------------------------------------


%  Filename    :   TestDetermineSpeciesRoleInReaction.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):

m = TranslateSBML('../../Test/test-data/species.xml');

s1 = m.species(1);
s2 = m.species(2);
s4 = m.species(4);

r1 = m.reaction(1);
r2 = m.reaction(2);
r3 = m.reaction(3);

fail = TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s4, r1, 0);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s2, r2, [1,0,0,2,0]);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s1, r1, [0,1,0,0,1]);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s4, r3, [0,0,1,0,0]);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s2, r3, [1,1,0,1,2]);

m = TranslateSBML('../../Test/test-data/l1v2-all.xml');

s1 = m.species(1);
s4 = m.species(4);

r1 = m.reaction(1);

fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s4, r1, 0);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s1, r1, [0,1,0,0,1]);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

s1 = m.species(1);
s2 = m.species(3);

r1 = m.reaction(1);

fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s2, r1, 0);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s1, r1, [0,1,0,0, 1]);

m = TranslateSBML('l2v3-all.xml');

s1 = m.species(1);

r1 = m.reaction(1);

fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s1, r1, [0,1,0,0, 1]);







