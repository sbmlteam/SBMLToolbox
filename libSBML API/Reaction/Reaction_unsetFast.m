function SBMLReaction = Reaction_unsetFast(SBMLReaction)
%
%   Reaction_setFast 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the reaction with the fast filed unset
%
%       SBMLReaction = Reaction_setFast(SBMLReaction, fast)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_unsetFast(SBMLReaction)', 'argument must be an SBML model structure'));
end;

SBMLReaction.fast = int32(0);
if (sbmlLevel == 2)
    SBMLReaction.fast = int32(-1);
    SBMLReaction.IsSetFast = int32(0);
end;
