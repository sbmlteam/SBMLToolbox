function value = Compartment_isSetOutside(SBMLCompartment)
%
%   Compartment_isSetOutside 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               1 if the outside has been set 
%               0 otherwise
%
%       value = Compartment_isSetOutside(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetOutside(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

value = ~isempty(SBMLCompartment.outside);