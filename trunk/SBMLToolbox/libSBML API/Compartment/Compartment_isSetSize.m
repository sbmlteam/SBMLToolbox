function value = Compartment_isSetSize(SBMLCompartment)
%
%   Compartment_isSetSize 
%             takes an SBMLCompartment structure 
%
%             and returns the value of the isSetSize field
%               1 if the size has been set 
%               0 otherwise
%
%       value = Compartment_isSetSize(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_isSetSize(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_isSetSize(SBMLCompartment)', 'no size field in a level 1 model'));    
end;

value = SBMLCompartment.isSetSize;