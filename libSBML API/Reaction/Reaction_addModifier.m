function reaction = Reaction_addModifier(SBMLReaction, SBMLModifier)
%
%   Reaction_addModifier 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLModifier structure
%
%             and returns 
%               the reaction with the modifier added
%
%       reaction = Reaction_addModifier(SBMLReaction, SBMLModifier)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'first argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'no modifiers in level 1 model'));
elseif (~isSBML_ModifierSpeciesReference(SBMLModifier, sbmlLevel))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'Reaction_addModifier(SBMLReaction, SBMLModifier)', 'second argument must be an SBML modifier structure', sbmlLevel));
end;

numberModifiers = length(SBMLReaction.modifier);

SBMLReaction.modifier(numberModifiers+1) = SBMLModifier;

reaction = SBMLReaction;

