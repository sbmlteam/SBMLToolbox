function y = test_conv()


%  Filename    :   test_conv.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id: RunTest.m 8188 2008-09-19 21:01:23Z sarahkeating $
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


test = 0;
Totalfail = 0;

test = test + 4;
fail = TestisValidUnitKind;
if (fail > 0)
    disp('isValidUnitKind failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestisIntegralNumber;
if (fail > 0)
    disp('isIntegralNumber failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestLoseWhiteSpace;
if (fail > 0)
    disp('LoseWhiteSpace failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestPairBrackets;
if (fail > 0)
    disp('PairBrackets failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestRemoveDuplicates;
if (fail > 0)
    disp('RemoveDuplicates failed');
end;
Totalfail = Totalfail + fail;

test = test + 6;
fail = TestSubstituteFunction;
if (fail > 0)
    disp('SubstituteFunction failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestSubstitute;
if (fail > 0)
    disp('Substitute failed');
end;
Totalfail = Totalfail + fail;

test = test + 4;
fail = TestSubstituteConstants;
if (fail > 0)
    disp('Substitute failed');
end;
Totalfail = Totalfail + fail;

test = test + 22;
fail = TestRearrange;
if (fail > 0)
    disp('Rearrange failed');
end;
Totalfail = Totalfail + fail;

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
