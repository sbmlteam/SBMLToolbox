function value = Compartment_isSetName(SBMLCompartment)
%
%   Compartment_isSetName 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               1 if the name has been set 
%               0 otherwise
%
%       value = Compartment_isSetName(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetName(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

value = ~isempty(SBMLCompartment.name);