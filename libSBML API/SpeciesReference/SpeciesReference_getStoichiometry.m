function stoichiometry = SpeciesReference_getStoichiometry(SBMLSpeciesReference)
%
%   SpeciesReference_getStoichiometry 
%             takes an SBMLSpeciesReference structure 
%
%             and returns 
%               the stoichiometry of the speciesreference as 
%               either an integer (Level 1 models)
%               or     a double (Level 2 models)
%
%       stoichiometry = SpeciesReference_getStoichiometry(SBMLSpeciesReference)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_SpeciesReference(SBMLSpeciesReference, sbmlLevel))
    error(sprintf('%s\n%s', 'SpeciesReference_getStoichiometry(SBMLSpeciesReference)', 'argument must be an SBML speciesreference structure'));
end;

stoichiometry = SBMLSpeciesReference.stoichiometry;
