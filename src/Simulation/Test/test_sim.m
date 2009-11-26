function y = test_sim()

%  Filename    :   test_sim.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: RunTest.m 7155 2008-06-26 20:24:00Z mhucka $
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



test = 0;
Totalfail = 0;

test = test + 5;
fail = TestAnalyseSpecies;
if (fail > 0)
    disp('AnalyseSpecies failed');
end;
Totalfail = Totalfail + fail;

test = test + 4;
fail = TestDealWithPiecewise;
if (fail > 0)
    disp('DealWithPiecewise failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetArgumentsFromLambdaFunction;
if (fail > 0)
    disp('GetArgumentsFromLambdaFunction failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
