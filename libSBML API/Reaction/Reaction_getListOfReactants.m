function reactants = Reaction_getListOfReactants(SBMLReaction)
%
%   Reaction_getListOfReactants 
%             takes an SBMLReaction structure 
%
%             and returns 
%               an array of SBML reactant structures defined within the reaction
%
%       reactants = Reaction_getListOfReactants(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getListOfReactants(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

reactants = SBMLReaction.reactant;
