function y = RunTest()

test = 0;
Totalfail = 0;

test = test + 3;
fail = TestAnalyseSpecies;
if (fail > 0)
    disp('AnalyseSpecies failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestDealWithPiecewise;
if (fail > 0)
    disp('DealWithPiecewise failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestGetArgumentsFromLambdaFunction;
if (fail > 0)
    disp('GetArgumentsFromLambdaFunction failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));