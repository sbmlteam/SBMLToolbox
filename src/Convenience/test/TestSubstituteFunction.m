function fail = TestSubstituteFunction
%
%   SubstituteFunction 
%             takes  1) a string representation of a formula 
%             and    2) an SBMLFunctionDefinition structure defining the formula
%
%             and returns 
%               the formula with the function substituted
%
%       NOTE: the OriginalFormula must contain the id of the
%       functionDefinition
%
%   EXAMPLE:
%           fD = SBMLFunmctionDefinition 
%               with id = 'g' and math = 'lambda(x,x+0.5)' 
%
%           formula = SubstituteFormula('g(y)', fD)
%           
%                   = 'y+0.5'

m = TranslateSBML('test2.xml');

fd = m.functionDefinition;
formula = 'f(y)';


fail = TestFunction('SubstituteFunction', 2, 1, formula, fd, 'y*2');