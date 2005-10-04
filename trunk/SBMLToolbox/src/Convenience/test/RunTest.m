function y = RunTest()

test = 0;
Totalfail = 0;

test = test + 4;
fail = TestCheckValidUnitKind;
if (fail > 0)
    disp('CheckValidUnitKind failed');
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

test = test + 1;
fail = TestSubstituteFunction;
if (fail > 0)
    disp('SubstituteFunction failed');
end;
Totalfail = Totalfail + fail;


disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));