function SBMLReaction = Reaction_unsetName(SBMLReaction)
%
%   Reaction_unsetName 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the reaction with the name unset
%               (i.e. name = '')
%
%       SBMLReaction = Reaction_unsetName(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_unsetName(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

SBMLReaction.name = '';
