function value = Compartment_isSetUnits(SBMLCompartment)
%
%   Compartment_isSetUnits 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               1 if the units has been set 
%               0 otherwise
%
%       value = Compartment_isSetUnits(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetUnits(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

value = ~isempty(SBMLCompartment.units);