function reaction = Reaction_addProduct(SBMLReaction, SBMLProduct)
%
%   Reaction_addProduct 
%             takes  1) an SBMLReaction structure 
%             and    2) an SBMLProduct structure
%
%             and returns 
%               the reaction with the product added
%
%       reaction = Reaction_addProduct(SBMLReaction, SBMLProduct)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_addProduct(SBMLReaction, SBMLProduct)', 'first argument must be an SBML reaction structure'));
elseif (~isSBML_SpeciesReference(SBMLProduct, sbmlLevel))
    error(sprintf('%s\n%s\n of the same SBML level, namely level %u', 'Reaction_addProduct(SBMLReaction, SBMLProduct)', 'second argument must be an SBML product structure', sbmlLevel));
end;

numberProducts = length(SBMLReaction.product);

SBMLReaction.product(numberProducts+1) = SBMLProduct;

reaction = SBMLReaction;

