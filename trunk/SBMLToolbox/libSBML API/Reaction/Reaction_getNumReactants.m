function number = Reaction_getNumReactants(SBMLReaction)
%
%   Reaction_getNumReactants 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the number of reactant structures defined within the reaction
%
%       number = Reaction_getNumReactants(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getNumReactants(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

number = 0;

if (~isempty(SBMLReaction.reactant))
    number = length(SBMLReaction.reactant);
end;
