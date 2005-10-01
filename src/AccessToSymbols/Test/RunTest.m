function y = RunTest()

m = TranslateSBML('test1.xml');

test = 0;
Totalfail = 0;

test = test + 1;
fail = TestcharFormula2sym;
if (fail == 1)
    disp('charFormula2sym failed');
end;

test = test + 1;
fail = TestCreateSymArray;
if (fail == 1)
    disp('CreateSymArray failed');
end;

test = test + 1;
fail = TestGetAllParameterSymbols;
if (fail == 1)
    disp('GetAllParameterSymbols failed');
end;

test = test + 1;
fail = TestGetAllParameterSymbolsUnique;
if (fail == 1)
    disp('GetAllParameterSymbolsUnique failed');
end;

test = test + 1;
fail = TestGetDegree;
if (fail == 1)
    disp('GetDegree failed');
end;


Totalfail = Totalfail + fail;

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));