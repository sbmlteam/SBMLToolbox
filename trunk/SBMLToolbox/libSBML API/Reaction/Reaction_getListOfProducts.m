function products = Reaction_getListOfProducts(SBMLReaction)
%
%   Reaction_getListOfProducts 
%             takes an SBMLReaction structure 
%
%             and returns 
%               an array of SBML product structures defined within the reaction
%
%       products = Reaction_getListOfProducts(SBMLReaction)

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getListOfProducts(SBMLReaction)', 'argument must be an SBML reaction structure'));
end;

products = SBMLReaction.product;
