function SBMLCompartment = Compartment_unsetName(SBMLCompartment)
%
%   Compartment_unsetName 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the name unset
%               (i.e. name = '')
%
%       SBMLCompartment = Compartment_unsetName(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_unsetName(SBMLCompartment)', 'argument must be an SBML compartment structure'));
end;

SBMLCompartment.name = '';