function value = Reaction_isSetFast(SBMLReaction)
%
%   Reaction_isSetFast 
%             takes an SBMLReaction structure 
%
%             and returns 
%               value of the isSetFast field (level 2 ONLY) 
%
%       value = Reaction_isSetFast(SBMLReaction)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_isSetFast(SBMLReaction)', 'argument must be an SBML reaction structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_isSetFast(SBMLReaction)', 'no isSetFast field in a level 1 model'));    
end;

value = SBMLReaction.IsSetFast;
