function value = Species_isSetInitialAmount(SBMLSpecies)
%
%   Species_isSetInitialAmount 
%             takes an SBMLSpecies structure 
%
%             and returns the value of the isSetInitialAmount field
%               1 if the initialAmount has been set 
%               0 otherwise
%
%       value = Species_isSetInitialAmount(SBMLSpecies)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Species(SBMLSpecies, sbmlLevel))
    error(sprintf('%s\n%s', 'Species_isSetInitialAmount(SBMLSpecies)', 'argument must be an SBML species structure'));
end;

value = SBMLSpecies.isSetInitialAmount;
