function SBMLCompartment = Compartment_unsetOutside(SBMLCompartment)
%
%   Compartment_unsetOutside 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the outside unset
%               (i.e. outside = '')
%
%       SBMLCompartment = Compartment_unsetOutside(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_unsetOutside(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

SBMLCompartment.outside = '';