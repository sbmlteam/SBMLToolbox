function modifier = Reaction_getModifier(SBMLReaction, number)
%
%   Reaction_getModifier 
%             takes  1) an SBMLReaction structure 
%             and    2) a number n
%
%             and returns 
%               the nth modifier structure defined within the reaction
%
%       modifier = Reaction_getModifier(SBMLReaction, number)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getModifier(SBMLReaction, number)', 'first argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getModifier(SBMLReaction, number)', 'no modifiers in level 1 model'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Reaction_getModifier(SBMLReaction, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLReaction.modifier))
    modifier = [];
else
    modifier = SBMLReaction.modifier(number);
end;
