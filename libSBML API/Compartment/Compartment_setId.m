function SBMLCompartment = Compartment_setId(SBMLCompartment, id)
%
%   Compartment_setId 
%             takes  1) an SBMLCompartment structure 
%             and    2) a string representing the id to be set
%
%             and returns 
%               the compartment with the id set
%
%       SBMLCompartment = Compartment_setId(SBMLCompartment, 'id')

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setId(SBMLCompartment, id)', 'first argument must be an SBML compartment structure'));
elseif (~ischar(id))
    error(sprintf('Compartment_setId(SBMLCompartment, id)\n%s', 'second argument must be a string representing the id of the compartment'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_setId(SBMLCompartment, id)', 'no id field in a level 1 model'));    
end;

SBMLCompartment.id = id;