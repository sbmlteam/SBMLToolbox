function SBMLSpeciesReference = SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)
%
%   SpeciesReference_setStoichiometry 
%             takes  1) an SBMLSpeciesReference structure 
%             and    2) an number representing the stoichiometry to be set
%                   NOTE: in Level 1 models stoichiometry must be an integer
%
%             and returns 
%               the speciesreference with the stoichiometry set
%
%       SBMLSpeciesReference = SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)', 'first argument must be an SBML model structure'));
elseif ((sbmlLevel ~= 2) &&(~isIntegralNumber(stoichiometry)))
    error(sprintf('SpeciesReference_setStoichiometry(SBMLSpeciesReference, stoichiometry)\n%s', 'second argument must be an integer in level 1 models'));
end;

if (sbmlLevel == 1)
    stoichiometry = int32(stoichiometry);
end;

SBMLSpeciesReference.stoichiometry = stoichiometry;
