function SBMLCompartment = Compartment_setVolume(SBMLCompartment, volume)
%
%   Compartment_setVolume 
%             takes  1) an SBMLCompartment structure 
%             and    2) a double representing the volume to be set
%
%             and returns 
%               the compartment with the volume set
%
%       SBMLCompartment = Compartment_setVolume(SBMLCompartment, volume)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setVolume(SBMLCompartment, volume)', 'first argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Compartment_setVolume(SBMLCompartment, volume)', 'no volume field in a level 2 model'));    
end;

SBMLCompartment.volume = volume;
SBMLCompartment.isSetVolume = 1;