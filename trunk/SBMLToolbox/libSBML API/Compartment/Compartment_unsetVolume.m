function SBMLCompartment = Compartment_unsetVolume(SBMLCompartment)
%
%   Compartment_unsetVolume 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the volume unset
%               (i.e. volume = NAN)
%
%       SBMLCompartment = Compartment_unsetVolume(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_unsetVolume(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Compartment_unsetVolume(SBMLCompartment)', 'no volume field in a level 2 model'));    
end;

warning off all;
SBMLCompartment.volume = 0/0;
SBMLCompartment.isSetVolume = 0;
warning on all;