function units = Compartment_getUnits(SBMLCompartment)
%
%   Compartment_getUnits 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the units of the compartment as a string
%
%       units = Compartment_getUnits(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getUnits(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

units = SBMLCompartment.units;