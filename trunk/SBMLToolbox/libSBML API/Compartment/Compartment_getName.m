function name = Compartment_getName(SBMLCompartment)
%
%   Compartment_getName 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the name of the compartment as a string
%
%       name = Compartment_getName(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getName(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

name = SBMLCompartment.name;