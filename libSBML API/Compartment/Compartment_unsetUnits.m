function SBMLCompartment = Compartment_unsetUnits(SBMLCompartment)
%
%   Compartment_unsetUnits 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the units unset
%               (i.e. units = '')
%
%       SBMLCompartment = Compartment_unsetUnits(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_unsetUnits(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

SBMLCompartment.units = '';