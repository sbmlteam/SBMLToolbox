function SBMLCompartment = Compartment_moveIdToName(SBMLCompartment)
%
%   Compartment_moveIdToName 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the model with id moved to the name field 
%               (unless the name field is already set)
%
%       SBMLCompartment = Compartment_moveIdToName(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_moveIdToName(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_moveIdToName(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

if (~Compartment_isSetName(SBMLCompartment))
    id = Compartment_getId(SBMLCompartment);
    SBMLCompartment = Compartment_setName(SBMLCompartment, id);
    SBMLCompartment = Compartment_setId(SBMLCompartment, '');
end;