function SBMLCompartment = Compartment_setSize(SBMLCompartment, size)
%
%   Compartment_setSize 
%             takes  1) an SBMLCompartment structure 
%             and    2) a double representing the size to be set
%
%             and returns 
%               the compartment with the size set
%
%       SBMLCompartment = Compartment_setSize(SBMLCompartment, size)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setSize(SBMLCompartment, size)', 'first argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_setSize(SBMLCompartment, size)', 'no size field in a level 1 model'));    
end;

SBMLCompartment.size = size;
SBMLCompartment.isSetSize = 1;