function reactant = Reaction_getReactantById(SBMLReaction, id)
%
%   Reaction_getReactantById 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id of the reactant to be found
%
%             and returns 
%               the reactant structure with the matching id 
%               or an empty structure if no such reactant exists
%               
%       reactant = Reaction_getReactantById(SBMLReaction, 'id')

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getReactantById(SBMLReaction, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Reaction_getReactantById(SBMLReaction, id)', 'second argument must be a string'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getReactantById(SBMLReaction, id)', 'no id field in a level 1 model'));   
end;

reactant = [];

for i = 1:length(SBMLReaction.reactant)
    if (strcmp(id, SBMLReaction.reactant(i).species))
        reactant = SBMLReaction.reactant(i);
        return;
    end;
end;
