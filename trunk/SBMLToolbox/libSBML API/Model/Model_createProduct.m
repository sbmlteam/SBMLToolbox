function [product, SBMLModel] = Model_createProduct(SBMLModel)
%
%   Model_createProduct 
%             takes an SBMLModel structure 
%
%             and returns 
%               as first argument the product structure created
%               within the model
%               and as second argument the SBML model structure with the
%               created product
%
%       NOTE: the product is added to the last reaction created
%
%       [product, SBMLModel] = Model_createProduct(SBMLModel)

% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_createProduct(SBMLModel)', 'first argument must be an SBML model structure'));
end;

product = SpeciesReference_create(SBMLModel.SBML_level);

if (length(SBMLModel.reaction) == 0)
    product = [];
    warning('Failed to create product');
else
    SBMLModel.reaction(end) = Reaction_addProduct(SBMLModel.reaction(end), product);
end;

