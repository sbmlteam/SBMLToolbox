function SBMLReaction = Reaction_moveNameToId(SBMLReaction)
%
%   Reaction_moveNameToId 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLReaction = Reaction_moveNameToId(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_moveNameToId(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_moveNameToId(SBMLReaction)', 'no id field in a level 1 model'));    
end;

if (~Reaction_isSetId(SBMLReaction))
    name = Reaction_getName(SBMLReaction);
    SBMLReaction = Reaction_setId(SBMLReaction, name);
    SBMLReaction = Reaction_setName(SBMLReaction, '');
end;
