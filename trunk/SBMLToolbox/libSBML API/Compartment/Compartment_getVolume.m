function volume = Compartment_getVolume(SBMLCompartment)
%
%   Compartment_getVolume 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the volume of the compartment as a double
%
%       volume = Compartment_getVolume(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getVolume(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Compartment_getVolume(SBMLCompartment)', 'no volume field in a level 2 model'));    
end;

volume = SBMLCompartment.volume;