function value = Reaction_isSetName(SBMLReaction)
%
%   Reaction_isSetName 
%             takes an SBMLReaction structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = Reaction_isSetName(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_isSetName(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

value = ~isempty(SBMLReaction.name);
