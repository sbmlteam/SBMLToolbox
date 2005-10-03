function fail = TestGetAllParametersUnique
% GetAllParametersUnique takes a SBMLModel 
% and returns 
%           1) an array of character names representing all parameters (both global and embedded) within the model 
%               with reaction names appended to the names of parameters
%               declared within a reaction
%           2) an array of the values of each parameter
%

m = TranslateSBML('test3.xml');

names = {'k', 'k_R2'};
values = [1, 0.1];

fail = TestFunction('GetAllParametersUnique', 1, 2, m, names, values);