function id = Compartment_getId(SBMLCompartment)
%
%   Compartment_getId 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the id of the compartment as a string
%
%       id = Compartment_getId(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getId(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_getId(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

id = SBMLCompartment.id;