function value = Species_isSetCharge(SBMLSpecies)
%
%   Species_isSetCharge 
%             takes an SBMLSpecies structure 
%
%             and returns the value of the isSetCharge field
%               1 if the charge has been set 
%               0 otherwise
%
%       value = Species_isSetCharge(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetCharge(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

value = SBMLSpecies.isSetCharge;
