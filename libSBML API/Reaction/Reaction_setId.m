function SBMLReaction = Reaction_setId(SBMLReaction, id)
%
%   Reaction_setId 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the reaction with the id set
%
%       SBMLReaction = Reaction_setId(SBMLReaction, 'id')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_setId(SBMLReaction, id)', 'first argument must be an SBML reaction structure'));
elseif (~ischar(id))
    error(sprintf('Reaction_setId(SBMLReaction, id)\n%s', 'second argument must be a string representing the id of the reaction'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_setId(SBMLReaction, id)', 'no id field in a level 1 model'));    
end;

SBMLReaction.id = id;
