function name = Reaction_getName(SBMLReaction)
%
%   Reaction_getName 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the name of the reaction as a string
%
%       name = Reaction_getName(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getName(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

name = SBMLReaction.name;
