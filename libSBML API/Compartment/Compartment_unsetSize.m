function SBMLCompartment = Compartment_unsetSize(SBMLCompartment)
%
%   Compartment_unsetSize 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the compartment with the size unset
%               (i.e. size = NAN)
%
%       SBMLCompartment = Compartment_unsetSize(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_unsetSize(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_unsetSize(SBMLCompartment)', 'no size field in a level 1 model'));    
end;

warning off all;
SBMLCompartment.size = 0/0;
SBMLCompartment.isSetSize = 0;
warning on all;