function SBMLReaction = Reaction_unsetKineticLaw(SBMLReaction)
%
%   Reaction_unsetKineticLaw 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the reaction with the kineticLaw unset
%               (i.e. kineticLaw = [])
%
%       SBMLReaction = Reaction_unsetKineticLaw(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_unsetKineticLaw(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

SBMLReaction.kineticLaw = [];
