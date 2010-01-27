function y = RunTest()


%  Filename    :   RunTest.m
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

v = ver('symbolic');

% this leaves out some tests for later versions as the syntax changed
if (str2num(v.Version) > 4)
    exclude = 1;
else
    exclude = 0;
end;

test = 0;
Totalfail = 0;

test = test + 1;
fail = TestcharFormula2sym;
if (fail > 0)
    disp('charFormula2sym failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestCreateSymArray;
if (fail > 0)
    disp('CreateSymArray failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParameterSymbols;
if (fail > 0)
    disp('GetAllParameterSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParameterSymbolsUnique;
if (fail > 0)
    disp('GetAllParameterSymbolsUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 5;
fail = TestGetDegree;
if (fail > 0)
    disp('GetDegree failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetGlobalParameterSymbols;
if (fail > 0)
    disp('GetGlobalParameterSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterSymbolsFromReaction;
if (fail > 0)
    disp('GetParameterSymbolsFromReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterSymbolsFromReactionUnique;
if (fail > 0)
    disp('GetParameterSymbolsFromReactionUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetSymbolicRateLawsFromReactions;
if (fail > 0)
    disp('TestGetSymbolicRateLawsFromReactions failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSymbolicRateLawsFromRules;
if (fail > 0)
    disp('TestGetSymbolicRateLawsFromRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 3;
fail = TestGetSpeciesSymbols;
if (fail > 0)
    disp('GetSpeciesSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetStoichiometryMatrixSyms;
if (fail > 0)
    disp('GetStoichiometryMatrixSyms failed');
end;
Totalfail = Totalfail + fail;

if (exclude == 0)
    test = test + 2;
    fail = TestGetSymbolicSpeciesAlgebraicRules;
    if (fail > 0)
        disp('TestGetSymbolicSpeciesAlgebraicRules failed');
    end;
    Totalfail = Totalfail + fail;

    test = test + 1;
    fail = TestGetSymbolicSpeciesAssignmentRules;
    if (fail > 0)
        disp('TestGetSymbolicSpeciesAssignmentRules failed');
    end;
    Totalfail = Totalfail + fail;

    test = test + 5;
    fail = TestAnalyseSpeciesSymbolic;
    if (fail > 0)
        disp('TestAnalyseSpeciesSymbolic failed');
    end;
    Totalfail = Totalfail + fail;
end;

test = test + 4;
fail = TestGetCompartmentSymbols;
if (fail > 0)
    disp('TestGetCompartmentSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetCompartmentTypeSymbols;
if (fail > 0)
    disp('TestGetCompartmentTypeSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesTypeSymbols;
if (fail > 0)
    disp('TestGetSpeciesTypeSymbols failed');
end;
Totalfail = Totalfail + fail;

if (exclude == 0)
    test = test + 1;
    fail = TestGetSymbolicSpeciesInitialAssignments;
    if (fail > 0)
        disp('TestGetSymbolicSpeciesInitialAssignments failed');
    end;
    Totalfail = Totalfail + fail;

    test = test + 1;
    fail = TestGetSymbolicCompartmentInitialAssignments;
    if (fail > 0)
        disp('TestGetSymbolicCompartmentInitialAssignments failed');
    end;
    Totalfail = Totalfail + fail;

    test = test + 1;
    fail = TestGetSymbolicParameterInitialAssignments;
    if (fail > 0)
        disp('TestGetSymbolicParameterInitialAssignments failed');
    end;
    Totalfail = Totalfail + fail;
end;

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
