function fail = TestGetAllParameters
% GetAllParameters takes a SBMLModel 
% and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%           2) an array of the values of each parameter
%

m = TranslateSBML('test3.xml');

names = {'k', 'k'};
values = [1, 0.1];

fail = TestFunction('GetAllParameters', 1, 2, m, names, values);