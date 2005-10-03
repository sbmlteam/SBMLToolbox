function fail = TestGetGlobalParameters
% GetGlobalParameters takes a SBMLModel 
% and returns 
%           1) an array of character names representing all global parameters within the model 
%           2) an array of the values of each parameter
%

m = TranslateSBML('test3.xml');

names = {'k'};
values = 1;

fail = TestFunction('GetGlobalParameters', 1, 2, m, names, values);