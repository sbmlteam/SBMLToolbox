function fast = Reaction_getFast(SBMLReaction)
%
%   Reaction_getFast 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the whether the reaction is fast as an integer
%                   1 - true  0 - false
%
%       fast = Reaction_getFast(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getFast(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

fast = SBMLReaction.fast;
