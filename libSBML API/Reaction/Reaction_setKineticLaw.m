function SBMLReaction = Reaction_setKineticLaw(SBMLReaction, SBMLKineticLaw)
%
%   Reaction_setKineticLaw 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLKineticLaw structure representing the kineticLaw to be set
%
%             and returns 
%               the reaction with the kineticLaw set
%
%       SBMLReaction = Reaction_setKineticLaw(SBMLReaction, SBMLKineticLaw)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_setKineticLaw(SBMLReaction, kineticLaw)', 'first argument must be an SBML reaction structure'));
elseif (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel))
    error(sprintf('Reaction_setKineticLaw(SBMLReaction, kineticLaw)\n%s\nof the same level, namely level %u', 'second argument must be an SBML KineticLaw structure', sbmlLevel));
end;

SBMLReaction.kineticLaw = SBMLKineticLaw;
