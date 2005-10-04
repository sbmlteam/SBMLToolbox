function fail = TestRemoveDuplicates
% RemoveDuplicates takes any array and returns it with any duplicates removed

input1 = [1, 3, 4, 3, 1, 5];
output1 = [1, 3, 4, 5];

input2 = 'adasfeds';
output2 = 'adsfe';

fail = TestFunction('RemoveDuplicates', 1, 1, input1, output1);
fail = fail + TestFunction('RemoveDuplicates', 1, 1, input2, output2);
