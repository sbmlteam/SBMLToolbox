function constant = Compartment_getConstant(SBMLCompartment)
%
%   Compartment_getConstant 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the constant of the compartment as an integer
%
%       constant = Compartment_getConstant(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getConstant(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_getConstant(SBMLCompartment)', 'no constant field in a level 1 model'));    
end;

constant = SBMLCompartment.constant;