function modifiers = Reaction_getListOfModifiers(SBMLReaction)
%
%   Reaction_getListOfModifiers 
%             takes an SBMLReaction structure 
%
%             and returns 
%               an array of SBML modifier structures defined within the reaction
%
%       modifiers = Reaction_getListOfModifiers(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getListOfModifiers(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getListOfModifiers(SBMLReaction)', 'no modifiers in level 1 model'));
end;

modifiers = SBMLReaction.modifier;
