function number = Reaction_getNumModifiers(SBMLReaction)
%
%   Reaction_getNumModifiers 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the number of modifier structures defined within the reaction
%
%       number = Reaction_getNumModifiers(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getNumModifiers(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getNumModifiers(SBMLReaction)', 'no modifiers in level 1 model'));
end;

number = 0;

if (~isempty(SBMLReaction.modifier))
    number = length(SBMLReaction.modifier);
end;
