function SBMLReaction = Reaction_moveIdToName(SBMLReaction)
%
%   Reaction_moveIdToName 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLReaction = Reaction_moveIdToName(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_moveIdToName(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_moveIdToName(SBMLReaction)', 'no id field in a level 1 model'));    
end;

if (~Reaction_isSetName(SBMLReaction))
    id = Reaction_getId(SBMLReaction);
    SBMLReaction = Reaction_setName(SBMLReaction, id);
    SBMLReaction = Reaction_setId(SBMLReaction, '');
end;
