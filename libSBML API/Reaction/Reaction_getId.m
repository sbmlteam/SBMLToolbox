function id = Reaction_getId(SBMLReaction)
%
%   Reaction_getId 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the id of the reaction as a string
%
%       id = Reaction_getId(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getId(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getId(SBMLReaction)', 'no id field in a level 1 model'));    
end;

id = SBMLReaction.id;
