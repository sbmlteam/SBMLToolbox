function reaction = Reaction_addReactant(SBMLReaction, SBMLReactant)
%
%   Reaction_addReactant 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLReactant structure
%
%             and returns 
%               the reaction with the reactant added
%
%       reaction = Reaction_addReactant(SBMLReaction, SBMLReactant)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_addReactant(SBMLReaction, SBMLReactant)', 'first argument must be an SBML reaction structure'));
elseif (~isSBML_SpeciesReference(SBMLReactant, sbmlLevel))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'Reaction_addReactant(SBMLReaction, SBMLReactant)', 'second argument must be an SBML reactant structure', sbmlLevel));
end;

numberReactants = length(SBMLReaction.reactant);

SBMLReaction.reactant(numberReactants+1) = SBMLReactant;

reaction = SBMLReaction;

