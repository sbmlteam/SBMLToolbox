function SBMLSpecies = Species_setCharge(SBMLSpecies, charge)
%
%   Species_setCharge 
%             takes  1) an SBMLSpecies structure 
%             and    2) an integer representing the charge to be set
%
%             and returns 
%               the species with the charge set
%
%       SBMLSpecies = Species_setCharge(SBMLSpecies, charge)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_setCharge(SBMLSpecies, charge)', 'first argument must be an SBML model structure'));
elseif (~isIntegralNumber(charge))
    error(sprintf('Species_setCharge(SBMLSpecies, charge)\n%s', 'second argument must be an integer representing the charge of the species'));
end;

SBMLSpecies.charge = charge;
SBMLSpecies.isSetCharge = 1;
