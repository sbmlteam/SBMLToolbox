function SBMLSpecies = Species_unsetCharge(SBMLSpecies)
%
%   Species_unsetCharge 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the species with the charge unset
%               (i.e. charge = NAN)
%
%       SBMLSpecies = Species_unsetCharge(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_unsetCharge(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

warning off all;
SBMLSpecies.charge = 0;
SBMLSpecies.isSetCharge = 0;
warning on all;
