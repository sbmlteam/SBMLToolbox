function fail = TestGetParameterFromReaction
% GetParameterFromReaction takes a SBMLReaction 
% and returns 
%           1) an array of character names representing all parameters defined 
%               within the kinetic law of the reaction 
%           2) an array of the values of each parameter
%

m = TranslateSBML('test3.xml');
r = m.reaction(2);

names = {'k'};
values = 0.1;

fail = TestFunction('GetParameterFromReaction', 1, 2, r, names, values);