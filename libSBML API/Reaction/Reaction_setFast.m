function SBMLReaction = Reaction_setFast(SBMLReaction, fast)
%
%   Reaction_setFast 
%             takes  1) an SBMLReaction structure 
%             and    2) an integer representing the fast to be set
%
%             and returns 
%               the reaction with the fast set
%
%       SBMLReaction = Reaction_setFast(SBMLReaction, fast)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_setFast(SBMLReaction, fast)', 'first argument must be an SBML reaction structure'));
elseif ((~isIntegralNumber(fast)) || (fast < 0) || (fast > 1))
    error(sprintf('Reaction_setFast(SBMLReaction, fast)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the reaction is fast'));
end;

SBMLReaction.fast = int32(fast);
if (sbmlLevel == 2)
    SBMLReaction.IsSetFast = int32(1);
end;
