function SBMLCompartment = Compartment_moveNameToId(SBMLCompartment)
%
%   Compartment_moveNameToId 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the model with name moved to the id field 
%               (unless the id field is already set)
%
%       SBMLCompartment = Compartment_moveNameToId(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_moveNameToId(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_moveNameToId(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

if (~Compartment_isSetId(SBMLCompartment))
    name = Compartment_getName(SBMLCompartment);
    SBMLCompartment = Compartment_setId(SBMLCompartment, name);
    SBMLCompartment = Compartment_setName(SBMLCompartment, '');
end;