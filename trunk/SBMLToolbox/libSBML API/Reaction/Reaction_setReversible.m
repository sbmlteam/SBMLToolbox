function SBMLReaction = Reaction_setReversible(SBMLReaction, reversible)
%
%   Reaction_setReversible 
%             takes  1) an SBMLReaction structure 
%             and    2) an integer representing the reversible to be set
%
%             and returns 
%               the reaction with the reversible set
%
%       SBMLReaction = Reaction_setReversible(SBMLReaction, reversible)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_setReversible(SBMLReaction, reversible)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(reversible)) || (reversible < 0) || (reversible > 1))
    error(sprintf('Reaction_setReversible(SBMLReaction, reversible)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the reaction is reversible'));
end;

SBMLReaction.reversible = int32(reversible);
