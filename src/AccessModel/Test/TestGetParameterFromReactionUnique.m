function fail = TestGetParameterFromReactionUnique
% GetParameterFromReactionUnique takes a SBMLReaction 
% and returns 
%           1) an array of character names representing all parameters defined 
%               within the kinetic law of the reaction with the reaction
%               name appended
%           2) an array of the values of each parameter
%

m = TranslateSBML('test3.xml');
r = m.reaction(2);

names = {'k_R2'};
values = 0.1;

fail = TestFunction('GetParameterFromReactionUnique', 1, 2, r, names, values);