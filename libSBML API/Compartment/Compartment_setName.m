function SBMLCompartment = Compartment_setName(SBMLCompartment, name)
%
%   Compartment_setName 
%             takes  1) an SBMLCompartment structure 
%             and    2) a string representing the name to be set
%
%             and returns 
%               the compartment with the name set
%
%       SBMLCompartment = Compartment_setName(SBMLCompartment, 'name')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setName(SBMLCompartment, name)', 'first argument must be an SBML compartment structure'));
elseif (~ischar(name))
    error(sprintf('Compartment_setName(SBMLCompartment, name)\n%s', 'second argument must be a string representing the name of the compartment'));
end;

SBMLCompartment.name = name;