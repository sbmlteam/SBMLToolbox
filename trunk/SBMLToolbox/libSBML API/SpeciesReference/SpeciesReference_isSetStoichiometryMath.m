function value = SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)
%
%   SpeciesReference_isSetStoichiometryMath 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               1 if the stoichiometryMath has been set 
%               0 otherwise
%
%       value = SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'SpeciesReference_isSetStoichiometryMath(SBMLSpeciesReference)', 'no stoichiometryMath field in a level 1 model'));    
end;

value = ~isempty(SBMLSpeciesReference.stoichiometryMath);
