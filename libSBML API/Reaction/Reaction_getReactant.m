function reactant = Reaction_getReactant(SBMLReaction, number)
%
%   Reaction_getReactant 
%             takes  1) an SBMLReaction structure 
%             and    2) a number n
%
%             and returns 
%               the nth reactant structure defined within the reaction
%
%       reactant = Reaction_getReactant(SBMLReaction, number)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getReactant(SBMLReaction, number)', 'first argument must be an SBML reaction structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Reaction_getReactant(SBMLReaction, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLReaction.reactant))
    reactant = [];
else
    reactant = SBMLReaction.reactant(number);
end;
