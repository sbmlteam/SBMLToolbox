function number = Reaction_getNumProducts(SBMLReaction)
%
%   Reaction_getNumProducts 
%             takes an SBMLReaction structure 
%
%             and returns 
%               the number of product structures defined within the reaction
%
%       number = Reaction_getNumProducts(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getNumProducts(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

number = 0;

if (~isempty(SBMLReaction.product))
    number = length(SBMLReaction.product);
end;
