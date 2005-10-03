function y = RunTest()

test = 0;
Totalfail = 0;

test = test + 4;
fail = TestDetermineSpeciesRoleInReaction;
if (fail > 0)
    disp('DetermineSpeciesRoleInReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParameters;
if (fail == 1)
    disp('GetAllParameters failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetAllParametersUnique;
if (fail == 1)
    disp('GetAllParametersUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetGlobalParameters;
if (fail == 1)
    disp('GetGlobalParameters failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterFromReaction;
if (fail == 1)
    disp('GetParameterFromReaction failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetParameterFromReactionUnique;
if (fail == 1)
    disp('GetParameterFromReactionUnique failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetRateLawsFromReactions;
if (fail == 1)
    disp('GetRateLawsFromReactions failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetRateLawsFromRules;
if (fail == 1)
    disp('GetRateLawsFromRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpecies;
if (fail == 1)
    disp('GetSpecies failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesAlgebraicRules;
if (fail == 1)
    disp('GetSpeciesAlgebraicRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetSpeciesAssignmentRules;
if (fail == 1)
    disp('GetSpeciesAssignmentRules failed');
end;
Totalfail = Totalfail + fail;

test = test + 1;
fail = TestGetStoichiometryMatrix;
if (fail == 1)
    disp('GetStoichiometryMatrix failed');
end;
Totalfail = Totalfail + fail;

test = test + 2;
fail = TestIsSpeciesInReaction;
if (fail > 0)
    disp('IsSpeciesInReaction failed');
end;
Totalfail = Totalfail + fail;

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));