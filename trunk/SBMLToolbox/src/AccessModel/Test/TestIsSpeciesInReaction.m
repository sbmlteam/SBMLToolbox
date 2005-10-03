function fail = TestIsSpeciesInReaction
% IsSpeciesInReaction(SBMLSpecies, SBMLReaction)takes an SBML species and  reaction
% and determines where the species takes part in the reaction
%
% returns   0   if species is NOT part of the reaction
% or        n   if the species is part of the reaction
%               where n is the number of times it occurs

m = TranslateSBML('test3.xml');

r1 = m.reaction(1);

s1 = m.species(1);
s2 = m.species(3);

fail = TestFunction('IsSpeciesInReaction', 2, 1, s1, r1, 1);
fail = fail + TestFunction('IsSpeciesInReaction', 2, 1, s2, r1, 0);