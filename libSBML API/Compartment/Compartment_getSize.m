function size = Compartment_getSize(SBMLCompartment)
%
%   Compartment_getSize 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the size of the compartment as a double
%
%       size = Compartment_getSize(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getSize(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_getSize(SBMLCompartment)', 'no size field in a level 1 model'));    
end;

size = SBMLCompartment.size;