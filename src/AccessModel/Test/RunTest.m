function y = RunTest()

m = TranslateSBML('test1.xml');

Function{1} = 'GetAllParameters';
Function{2} = 'GetAllParametersUnique'; 
Function{3} = 'GetGlobalParameters';
Function{4} = 'GetParameterFromReaction'; 
Function{5} = 'GetParameterFromReactionUnique';
Function{6} = 'GetRateLawsFromReactions'; 
Function{7} = 'GetRateLawsFromRules'; 
Function{8} = 'GetSpecies'; 
Function{9} = 'GetSpeciesAlgebraicRules'; 
Function{10} = 'GetSpeciesAssignmentRules'; 
Function{11} = 'GetStoichiometryMatrix'; 

test = 0;
Totalfail = 0;

test = test + 1;
fail = TestFunction('GetSpecies', m, 2, {'S1', 'S2'}, [1.5e-15, 1.5e-15]);

test = test + 1;
fail = TestFunction('GetAllParameters', m, 2, {'k_1', 'k_2'}, [1, 0]);

test = test + 1;
fail = TestFunction('GetAllParametersUnique', m, 2, {'k_1_R1', 'k_2_R2'}, [1, 0]);

test = test + 1;
fail = TestFunction('GetGlobalParameters', m, 0);

test = test + 1;
fail = TestFunction('GetParameterFromReaction', m.reaction(1), 2, {'k_1'}, [1]);

test = test + 1;
fail = TestFunction('GetParameterFromReactionUnique', m.reaction(1), 2, {'k_1_R1'}, [1]);

test = test + 1;
fail = TestFunction('GetParameterFromReactionUnique', m.reaction(2), 2, {'k_2_R2'}, [0]);

test = test + 1;
fail = TestFunction('GetRateLawsFromReactions', m, 2, {'S1', 'S2'}, {' - (k_1_R1*S1) + (k_2_R2*S2)', ' + (k_1_R1*S1) - (k_2_R2*S2)'});

test = test + 1;
fail = TestFunction('GetRateLawsFromRules', m, 0);

test = test + 1;
fail = TestFunction('GetSpeciesAssignmentRules', m, 0);

test = test + 1;
fail = TestFunction('GetSpeciesAssignmentRules', m, 0);

test = test + 1;
fail = TestFunction('GetStoichiometryMatrix', m, 2, [1, 1; 1, 1], {'S1', 'S2'});






Totalfail = Totalfail + fail;

disp(sprintf('Number tests: %d', test));
disp(sprintf('Number fails: %d', Totalfail));
disp(sprintf('Pass rate: %d%%', ((test-Totalfail)/test)*100));