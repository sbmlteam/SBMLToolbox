function SBMLSpeciesReference = SpeciesReference_setDenominator(SBMLSpeciesReference, denominator)
%
%   SpeciesReference_setDenominator 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) an integer representing the denominator to be set
%
%             and returns 
%               the speciesreference with the denominator set
%
%       SBMLSpeciesReference = SpeciesReference_setDenominator(SBMLSpeciesReference, denominator)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_setDenominator(SBMLSpeciesReference, denominator)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(denominator))
    error(sprintf('SpeciesReference_setDenominator(SBMLSpeciesReference, denominator)\n%s', 'second argument must be an integer representing the denominator of the speciesreference'));
end;

SBMLSpeciesReference.denominator = denominator;
