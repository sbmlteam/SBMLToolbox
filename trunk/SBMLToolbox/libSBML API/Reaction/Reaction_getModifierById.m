function modifier = Reaction_getModifierById(SBMLReaction, id)
%
%   Reaction_getModifierById 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id of the modifier to be found
%
%             and returns 
%               the modifier structure with the matching id 
%               or an empty structure if no such modifier exists
%               
%       modifier = Reaction_getModifierById(SBMLReaction, 'id')

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'second argument must be a string'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getModifierById(SBMLReaction, id)', 'no id or modifier field in a level 1 model'));   
end;

modifier = [];

for i = 1:length(SBMLReaction.modifier)
    if (strcmp(id, SBMLReaction.modifier(i).species))
        modifier = SBMLReaction.modifier(i);
        return;
    end;
end;
