function fail = TestAnalyseSpecies
% AnalyseSpecies takes a matlab sbml model structure and outputs a
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


%  Filename    :   TestAnalyseSpecies.m
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


m = TranslateSBML('../../Test/test-data/l1v1.xml');

output(1).Name = {'S1'};
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = 1.5e-15;
output(1).isConcentration = 0;
output(1).compartment = 'compartment';
output(1).ChangedByReaction = 1;
output(1).KineticLaw = {' - (k_1_R1*S1) + (k_2_R2*S2)'};
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 0;
output(1).AlgebraicRule = '';
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

output(2).Name = {'S2'};
output(2).constant = 0;
output(2).boundaryCondition = 0;
output(2).initialValue = 1.45;
output(2).isConcentration = 0;
output(2).compartment = 'compartment';
output(2).ChangedByReaction = 1;
output(2).KineticLaw = {' + (k_1_R1*S1) - (k_2_R2*S2)'};
output(2).ChangedByRateRule = 0;
output(2).RateRule = '';
output(2).ChangedByAssignmentRule = 0;
output(2).AssignmentRule = '';
output(2).InAlgebraicRule = 0;
output(2).AlgebraicRule = '';
output(2).ConvertedToAssignRule = 0;
output(2).ConvertedRule = '';

output(3).Name = {'x0'};
output(3).constant = 0;
output(3).boundaryCondition = 0;
output(3).initialValue = 1;
output(3).isConcentration = 0;
output(3).compartment = 'compartment';
output(3).ChangedByReaction = 0;
output(3).KineticLaw = '';
output(3).ChangedByRateRule = 0;
output(3).RateRule = '';
output(3).ChangedByAssignmentRule = 0;
output(3).AssignmentRule = '';
output(3).InAlgebraicRule = 0;
output(3).AlgebraicRule = '';
output(3).ConvertedToAssignRule = 0;
output(3).ConvertedRule = '';

fail = TestFunction('AnalyseSpecies', 1, 1, m, output);

% m = TranslateSBML('../../Test/test-data/test2_sim.xml');
%  
% output(1).Name = {'S3'};
% output(1).constant = 0;
% output(1).boundaryCondition = 0;
% output(1).initialValue = 3e-15;
% output(1).isConcentration = 0;
% output(1).compartment = 'compartment';
% output(1).ChangedByReaction = 1;
% output(1).KineticLaw = {' + (k_R2*S2)'};
% output(1).ChangedByRateRule = 0;
% output(1).RateRule = '';
% output(1).ChangedByAssignmentRule = 1;
% output(1).AssignmentRule = {'3+4'};
% output(1).InAlgebraicRule = 1;
% output(1).AlgebraicRule = {{'X+S1-S3'}};
% output(1).ConvertedToAssignRule = 0;
% output(1).ConvertedRule = '';
% 
% fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);
 
% m = TranslateSBML('test3.xml');
% 
% output(1).Name = {'s1'};
% output(1).constant = 0;
% output(1).boundaryCondition = 1;
% output(1).initialValue = 0;
% output(1).isConcentration = 0;
% output(1).compartment = 'c';
% output(1).ChangedByReaction = 0;
% output(1).KineticLaw = '';
% output(1).ChangedByRateRule = 1;
% output(1).RateRule = {'5'};
% output(1).ChangedByAssignmentRule = 0;
% output(1).AssignmentRule = '';
% output(1).InAlgebraicRule = 0;
% output(1).AlgebraicRule = '';
% output(1).ConvertedToAssignRule = 0;
% output(1).ConvertedRule = '';
% 
% fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);
% 
% m = TranslateSBML('test7.xml');
% 
% output(1).Name = {'X'};
% output(1).constant = 0;
% output(1).boundaryCondition = 0;
% output(1).initialValue = 2;
% output(1).isConcentration = 1;
% output(1).compartment = 'compartment';
% output(1).ChangedByReaction = 0;
% output(1).KineticLaw = '';
% output(1).ChangedByRateRule = 0;
% output(1).RateRule = '';
% output(1).ChangedByAssignmentRule = 0;
% output(1).AssignmentRule = '';
% output(1).InAlgebraicRule = 1;
% output(1).AlgebraicRule = {{'X+S1-S3'}};
% output(1).ConvertedToAssignRule = 1;
% output(1).ConvertedRule = '-S1+S3';
% 
% fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);
% 
% m = TranslateSBML('test3_l2v2.xml');
% 
% output(1).Name = {'X0'};
% output(1).speciesType='Glucose';
% output(1).constant = 0;
% output(1).boundaryCondition = 0;
% output(1).initialValue = 0.026;
% output(1).isConcentration = 0;
% output(1).compartment = 'cell';
% output(1).ChangedByReaction = 0;
% output(1).KineticLaw = '';
% output(1).ChangedByRateRule = 0;
% output(1).RateRule = '';
% output(1).ChangedByAssignmentRule = 0;
% output(1).AssignmentRule = '';
% output(1).InAlgebraicRule = 0;
% output(1).AlgebraicRule = '';
% output(1).ConvertedToAssignRule = 0;
% output(1).ConvertedRule = '';
% 
% fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);
