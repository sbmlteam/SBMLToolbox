function outside = Compartment_getOutside(SBMLCompartment)
%
%   Compartment_getOutside 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the outside of the compartment as a string
%
%       outside = Compartment_getOutside(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getOutside(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

outside = SBMLCompartment.outside;