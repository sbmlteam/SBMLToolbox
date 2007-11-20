function fail = TestAnalyseSpeciesSymbolic
% AnalyseSpeciesSymbolic takes a matlab sbml model structure and outputs a
% structure detailing the species and how they are manipulated within the
% model
% 
% the structure fields are
%     Name
%     constant
%     boundaryCondition
%     initialValue
%     isConcentration
%     compartment
%     ChangedByReaction
%     KineticLaw
%     ChangedByRateRule
%     RateRule
%     ChangedByAssignmentRule
%     AssignmentRule
%     InAlgebraicRule
%     AlgebraicRule
%     ConvertedToAssignRule
%     ConvertedRule


%  Filename    :   TestAnalyseSpeciesSymbolic.m
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

fail = 0;
m = TranslateSBML('test6.xml');

syms S1 S3 kf_R1 c;

output(1).Name = [S1];
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = 1e-15;
output(1).isConcentration = 0;
output(1).compartment = c;
output(1).ChangedByReaction = 1;
output(1).KineticLaw = [-(kf_R1*S1*S3)];
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 0;
output(1).AlgebraicRule = '';
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

fail = fail + TestFunction('AnalyseSpeciesSymbolic', 1, 1, m, output);

m = TranslateSBML('test7.xml');

syms X S1 S3 compartment;

output(1).Name = [X];
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = 2;
output(1).isConcentration = 1;
output(1).compartment = compartment;
output(1).ChangedByReaction = 0;
output(1).KineticLaw = '';
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 1;
output(1).AlgebraicRule = [X+S1-S3];
output(1).ConvertedToAssignRule = 1;
output(1).ConvertedRule = [-S1+S3];

% fail = fail + TestFunction('AnalyseSpeciesSymbolic', 1, 1, m, output);
% 
m = TranslateSBML('test10.xml');

syms X0 y1 X1 cell1;

output(1).Name = X0;
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = -1;
output(1).hasInitialAssignment = 1;
output(1).initialAssignment = [2*y1];
output(1).isConcentration = 0;
output(1).compartment = cell1;
output(1).ChangedByReaction = 0;
output(1).KineticLaw = '';
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 0;
output(1).AlgebraicRule = '';
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

output(2).Name = X1;
output(2).constant = 0;
output(2).boundaryCondition = 0;
output(2).initialValue = -1;
output(2).hasInitialAssignment = 0;
output(2).initialAssignment = '';
output(2).isConcentration = 0;
output(2).compartment = cell1;
output(2).ChangedByReaction = 0;
output(2).KineticLaw = '';
output(2).ChangedByRateRule = 0;
output(2).RateRule = '';
output(2).ChangedByAssignmentRule = 0;
output(2).AssignmentRule = '';
output(2).InAlgebraicRule = 0;
output(2).AlgebraicRule = '';
output(2).ConvertedToAssignRule = 0;
output(2).ConvertedRule = '';

fail = fail + TestFunction('AnalyseSpeciesSymbolic', 1, 1, m, output);
