function product = Reaction_getProductById(SBMLReaction, id)
%
%   Reaction_getProductById 
%             takes  1) an SBMLReaction structure 
%             and    2) a string representing the id of the product to be found
%
%             and returns 
%               the product structure with the matching id 
%               or an empty structure if no such product exists
%               
%       product = Reaction_getProductById(SBMLReaction, 'id')

% get level
sbmlLevel = 2;
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    sbmlLevel = 1;
end;

% check that input is correct
if (~isSBML_Reaction(SBMLReaction, sbmlLevel))
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'first argument must be an SBML model structure'));
elseif (~ischar(id))
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'second argument must be a string'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Reaction_getProductById(SBMLReaction, id)', 'no id field in a level 1 model'));   
end;

product = [];

for i = 1:length(SBMLReaction.product)
    if (strcmp(id, SBMLReaction.product(i).species))
        product = SBMLReaction.product(i);
        return;
    end;
end;
