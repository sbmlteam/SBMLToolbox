function SBMLCompartment = Compartment_setUnits(SBMLCompartment, units)
%
%   Compartment_setUnits 
%             takes  1) an SBMLCompartment structure 
%             and    2) a string representing the units to be set
%
%             and returns 
%               the compartment with the units set
%
%       SBMLCompartment = Compartment_setUnits(SBMLCompartment, 'units')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setUnits(SBMLCompartment, units)', 'first argument must be an SBML compartment structure'));
elseif (~ischar(units))
    error(sprintf('Compartment_setUnits(SBMLCompartment, units)\n%s', 'second argument must be a string representing the units of the compartment'));
end;

SBMLCompartment.units = units;