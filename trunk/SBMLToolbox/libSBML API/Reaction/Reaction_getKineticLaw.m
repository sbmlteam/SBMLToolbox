function kineticLaw = Reaction_getKineticLaw(SBMLReaction)
%
%   Reaction_getKineticLaw 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the kineticLaw of the reaction as an SBML KineticLaw
%               structure
%
%       kineticLaw = Reaction_getKineticLaw(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getKineticLaw(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

kineticLaw = SBMLReaction.kineticLaw;
