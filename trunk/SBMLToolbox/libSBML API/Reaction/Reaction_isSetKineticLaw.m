function value = Reaction_isSetKineticLaw(SBMLReaction)
%
%   Reaction_isSetKineticLaw 
%             takes an SBMLReaction structure 
%
%             and returns 
%               1 if the kineticLaw has been set 
%               0 otherwise
%
%       value = Reaction_isSetKineticLaw(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_isSetKineticLaw(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

value = ~isempty(SBMLReaction.kineticLaw);
