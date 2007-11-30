function fail = TestGetSpeciesRateLaws(SBMLModel)
% GetSpeciesRateLaws(SBMLModel) takes an SBML model 
% returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%--------------------------------------------------------------------------


%  Filename    :   TestGetSpeciesRateLaws.m
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


m = TranslateSBML('../../Test/test-data/algebraicRules.xml');

syms S1 S2 S3 X k k_R2 X0 X1 v_in t_in;

species = [S1, S2, S3, X];
rateLaws = [-k*S1, k*S1-k_R2*S2, k_R2*S2, sym('0')];

fail = TestFunction('GetSymbolicRateLawsFromReactions', 1, 2, m, species, rateLaws);

m = TranslateSBML('../../Test/test-data/l2v2-newComponents.xml');

species = [X0, X1];
rateLaws = [-(v_in*X0/t_in), sym('0')];

fail = TestFunction('GetSymbolicRateLawsFromReactions', 1, 2, m, species, rateLaws);
