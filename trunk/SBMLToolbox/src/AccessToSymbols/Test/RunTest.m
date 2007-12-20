function y = RunTest()


%  Filename    :   RunTest.m
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

test = test + 2;
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

test = test + 2;
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

test = test + 3;
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

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));
