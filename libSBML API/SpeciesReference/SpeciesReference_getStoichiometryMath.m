function stoichiometryMath = SpeciesReference_getStoichiometryMath(SBMLSpeciesReference)
%
%   SpeciesReference_getStoichiometryMath 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               the stoichiometryMath of the speciesreference as a string
%
%       stoichiometryMath = SpeciesReference_getStoichiometryMath(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_getStoichiometryMath(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'SpeciesReference_getStoichiometryMath(SBMLSpeciesReference)', 'no stoichiometryMath field in a level 1 model'));    
end;

stoichiometryMath = SBMLSpeciesReference.stoichiometryMath;
