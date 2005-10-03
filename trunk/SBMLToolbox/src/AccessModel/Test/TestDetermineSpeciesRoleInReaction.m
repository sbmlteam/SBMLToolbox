function fail = TestDetermineSpeciesRoleInReaction
% DetermineSpeciesRoleInReaction(SBMLSpecies, SBMLReaction)takes a SBML species and  reaction
% and determines where the species takes part in the reaction
%
% returns   0   if species is NOT part of the reaction
% or        an array indicting whether the species is a product,
%                   reactant or modifier
%           and recording the position in the list of products/reactants
%
%           [isProduct, isReactant, isModifier, positionInProductList,
%           positionInReactantList]
%
%--------------------------------------------------------------------------
% EXAMPLE:    y   =   DetermineSpeciesRoleInReaction(s, r)
%                 =   0                 if s is not in r
%                 =   [1, 0, 0, 2, 0]   if s is product no 2 in r 
%                 =   [0, 1, 0, 0, 1]   if s is reactant no 1 in r
%                 =   [0, 0, 1, 0, 0]   if s is a modifier in r
%--------------------------------------------------------------------------

m = TranslateSBML('test2.xml');

s1 = m.species(1);
s2 = m.species(2);
s4 = m.species(4);

r1 = m.reaction(1);
r2 = m.reaction(2);
r3 = m.reaction(3);

fail = TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s4, r1, 0);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s2, r2, [1,0,0,2,0]);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s1, r1, [0,1,0,0,1]);
fail = fail + TestFunction('DetermineSpeciesRoleInReaction', 2, 1, s4, r3, [0,0,1,0,0]);










