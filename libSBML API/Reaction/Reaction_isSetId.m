function value = Reaction_isSetId(SBMLReaction)
%
%   Reaction_isSetId 
%             takes an SBMLReaction structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = Reaction_isSetId(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_isSetId(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_isSetId(SBMLReaction)', 'no id field in a level 1 model'));    
end;

value = ~isempty(SBMLReaction.id);
