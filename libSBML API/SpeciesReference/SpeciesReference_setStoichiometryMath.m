function SBMLSpeciesReference = SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)
%
%   SpeciesReference_setStoichiometryMath 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) a string representing the stoichiometryMath to be set
%
%             and returns 
%               the speciesreference with the stoichiometryMath set
%
%       SBMLSpeciesReference = SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, 'stoichiometryMath')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)', 'first argument must be an SBML speciesreference structure'));
elseif (~ischar(stoichiometryMath))
    error(sprintf('SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)\n%s', 'second argument must be a string representing the stoichiometryMath of the speciesreference'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometryMath(SBMLSpeciesReference, stoichiometryMath)', 'no stoichiometryMath field in a level 1 model'));    
end;

SBMLSpeciesReference.stoichiometryMath = stoichiometryMath;
