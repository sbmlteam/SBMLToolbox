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

m = TranslateSBML('test1.xml');

output= struct('Name', 'constant', 'boundaryCondition', 'initialValue', 'ChangedByReaction', ...
    'KineticLaw', 'ChangedByRateRule', 'RateRule', 'ChangedByAssignmentRule', 'AssignmentRule', ...
    'InAlgebraicRule', 'AlgebraicRule', 'ConvertedToAssignRule', 'ConvertedRule');

output(1).Name = {'S1'};
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = 1e-15;
output(1).ChangedByReaction = 1;
output(1).KineticLaw = {' - (kf_R1*S1*S3)'};
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 0;
output(1).AlgebraicRule = '';
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

fail = TestFunction('AnalyseSpecies', 1, 1, m, output);

m = TranslateSBML('test2.xml');

output(1).Name = {'S3'};
output(1).constant = 0;
output(1).boundaryCondition = 0;
output(1).initialValue = 3e-15;
output(1).ChangedByReaction = 1;
output(1).KineticLaw = {' + (k_R2*S2)'};
output(1).ChangedByRateRule = 0;
output(1).RateRule = '';
output(1).ChangedByAssignmentRule = 1;
output(1).AssignmentRule = {'3+4'};
output(1).InAlgebraicRule = 1;
output(1).AlgebraicRule = {{'X+S1-S3'}};
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);

m = TranslateSBML('test3.xml');

output(1).Name = {'s1'};
output(1).constant = 0;
output(1).boundaryCondition = 1;
output(1).initialValue = 0;
output(1).ChangedByReaction = 0;
output(1).KineticLaw = '';
output(1).ChangedByRateRule = 1;
output(1).RateRule = {'5'};
output(1).ChangedByAssignmentRule = 0;
output(1).AssignmentRule = '';
output(1).InAlgebraicRule = 0;
output(1).AlgebraicRule = '';
output(1).ConvertedToAssignRule = 0;
output(1).ConvertedRule = '';

fail = fail + TestFunction('AnalyseSpecies', 1, 1, m, output);
