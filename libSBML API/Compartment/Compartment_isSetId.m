function value = Compartment_isSetId(SBMLCompartment)
%
%   Compartment_isSetId 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               1 if the id has been set 
%               0 otherwise
%
%       value = Compartment_isSetId(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetId(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_isSetId(SBMLCompartment)', 'no id field in a level 1 model'));    
end;

value = ~isempty(SBMLCompartment.id);