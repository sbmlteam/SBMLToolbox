function SBMLReaction = Reaction_setName(SBMLReaction, name)
%
%   Reaction_setName 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the reaction with the name set
%
%       SBMLReaction = Reaction_setName(SBMLReaction, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_setName(SBMLReaction, name)', 'first argument must be an SBML reaction structure'));
elseif (~ischar(name))
    error(sprintf('Reaction_setName(SBMLReaction, name)\n%s', 'second argument must be a string representing the name of the reaction'));
end;

SBMLReaction.name = name;
