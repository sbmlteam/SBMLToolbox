function charge = Species_getCharge(SBMLSpecies)
%
%   Species_getCharge 
%             takes an SBMLSpecies structure 
%
%             and returns 
%               the charge of the species as an integer
%
%       charge = Species_getCharge(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_getCharge(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

charge = SBMLSpecies.charge;
