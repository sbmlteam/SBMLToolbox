function denominator = SpeciesReference_getDenominator(SBMLSpeciesReference)
%
%   SpeciesReference_getDenominator 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               the denominator of the speciesreference as an integer
%
%       denominator = SpeciesReference_getDenominator(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_getDenominator(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
end;

denominator = SBMLSpeciesReference.denominator;
