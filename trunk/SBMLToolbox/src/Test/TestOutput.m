function fail = TestOutput

%  Filename    :   TestOutput.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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

if (~isdir('Out-test'))
mkdir ('Out-test');
end;

if exist('OCTAVE_VERSION')
  ff = dir('test-data');
  j = 1;
  for i=1:length(ff)
    if (ff(i).isdir == 0 && ~isempty(strfind(ff(i).name, '.xml')))
      files(j) = ff(i);
      j = j+1;
    end;
  end;
else
  files = dir('test-data/*.xml');
end;

fail = 0;

for i=1:length(files)
  m = TranslateSBML(sprintf('test-data/%s', files(i).name));
  OutputSBML(m, sprintf('Out-test/%s', files(i).name));
  if (CompareFiles(sprintf('test-data/%s', files(i).name), sprintf('Out-test/%s', files(i).name)))
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

