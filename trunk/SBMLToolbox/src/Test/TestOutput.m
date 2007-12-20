function fail = TestOutput

if (~isdir('Out-test'))
mkdir ('Out-test');
end;
files = dir('test-data/*.xml');
fail = 0;

for i=1:length(files)
  m = TranslateSBML(sprintf('test-data/%s', files(i).name));
  OutputSBML(m, sprintf('Out-test/%s', files(i).name));
  if (~CompareFiles(sprintf('test-data/%s', files(i).name), sprintf('Out-test/%s', files(i).name)))
    disp(sprintf('Output of %s failed', files(i).name));
    fail = fail + 1;
  end;
end;
 
  
% m = TranslateSBML('test-data/algebraicRules.xml');
% OutputSBML(m, 'Out-test/algebraicRules.xml');
% 
% m = TranslateSBML('test-data/functionDefinition.xml');
% OutputSBML(m, 'Out-test/functionDefinition.xml');
% 
% m = TranslateSBML('test-data/initialAssignments.xml');
% OutputSBML(m, 'Out-test/initialAssignments.xml');
% 
% m = TranslateSBML('test-data/l1v1.xml');
% OutputSBML(m, 'Out-test/l1v1.xml');
% 
% m = TranslateSBML('test-data/l1v2-all.xml');
% OutputSBML(m, 'Out-test/l1v2-all.xml');
% 
% m = TranslateSBML('test-data/l2v1-all.xml');
% OutputSBML(m, 'Out-test/l2v1-all.xml');
% 
% m = TranslateSBML('test-data/l2v2-all.xml');
% OutputSBML(m, 'Out-test/l2v2-all.xml');
% 
% m = TranslateSBML('test-data/l2v2-newComponents.xml');
% OutputSBML(m, 'Out-test/l2v2-newComponents.xml');
% 
% m = TranslateSBML('test-data/l2v3-all.xml');
% OutputSBML(m, 'Out-test/l2v3-all.xml');
% 
% m = TranslateSBML('test-data/nestedPiecewise.xml');
% OutputSBML(m, 'Out-test/nestedPiecewise.xml');
% 
% m = TranslateSBML('test-data/piecewise.xml');
% OutputSBML(m, 'Out-test/piecewise.xml');
% 
% m = TranslateSBML('test-data/rateRules.xml');
% OutputSBML(m, 'Out-test/rateRules.xml');
% 
% m = TranslateSBML('test-data/sparseStoichiometry.xml');
% OutputSBML(m, 'Out-test/sparseStoichiometry.xml');
% 
% m = TranslateSBML('test-data/species.xml');
% OutputSBML(m, 'Out-test/species.xml');
% 

