function reversible = Reaction_getReversible(SBMLReaction)
%
%   Reaction_getReversible 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the whether the reaction is reversible as an integer
%                   1 - true  0 - false
%
%       reversible = Reaction_getReversible(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getReversible(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

reversible = SBMLReaction.reversible;
