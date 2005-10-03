function y = RunTest()

test = 0;
Totalfail = 0;

test = test + 1;
fail = TestcharFormula2sym;
if (fail == 1)
    disp('charFormula2sym failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestCreateSymArray;
if (fail == 1)
    disp('CreateSymArray failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParameterSymbols;
if (fail == 1)
    disp('GetAllParameterSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParameterSymbolsUnique;
if (fail == 1)
    disp('GetAllParameterSymbolsUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 5;
fail = TestGetDegree;
if (fail > 0)
    disp('GetDegree failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetEquilibrium;
if (fail == 1)
    disp('GetEquilibrium failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetGlobalParameterSymbols;
if (fail == 1)
    disp('GetGlobalParameterSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterSymbolsFromReaction;
if (fail == 1)
    disp('GetParameterSymbolsFromReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterSymbolsFromReactionUnique;
if (fail == 1)
    disp('GetParameterSymbolsFromReactionUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesRateLaws;
if (fail == 1)
    disp('GetSpeciesRateLaws failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesSymbols;
if (fail == 1)
    disp('GetSpeciesSymbols failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetStoichiometryMatrixSyms;
if (fail == 1)
    disp('GetStoichiometryMatrixSyms failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));