function product = Reaction_getProduct(SBMLReaction, number)
%
%   Reaction_getProduct 
%             takes  1) an SBMLReaction structure 
%             and    2) a number n
%
%             and returns 
%               the nth product structure defined within the reaction
%
%       product = Reaction_getProduct(SBMLReaction, number)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct


if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getProduct(SBMLReaction, number)', 'first argument must be an SBML reaction structure'));
elseif ((number < 1) || (~isIntegralNumber(number)))
    error(sprintf('%s\n%s', 'Reaction_getProduct(SBMLReaction, number)', 'second argument must be a positive integer'));
end;

if (number > length(SBMLReaction.product))
    product = [];
else
    product = SBMLReaction.product(number);
end;
