function value = Compartment_isSetVolume(SBMLCompartment)
%
%   Compartment_isSetVolume 
%             takes an SBMLCompartment structure 
%
%             and returns the value of the isSetVolume field
%               1 if the volume has been set 
%               0 otherwise
%
%       value = Compartment_isSetVolume(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetVolume(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 1)
    error(sprintf('%s\n%s', 'Compartment_isSetVolume(SBMLCompartment)', 'no volume field in a level 2 model'));    
end;

value = SBMLCompartment.isSetVolume;