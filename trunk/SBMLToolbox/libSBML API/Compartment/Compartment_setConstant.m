function SBMLCompartment = Compartment_setConstant(SBMLCompartment, constant)
%
%   Compartment_setConstant 
%             takes  1) an SBMLCompartment structure 
%             and    2) an integer representing the constant to be set
%
%             and returns 
%               the compartment with the constant set
%
%       SBMLCompartment = Compartment_setConstant(SBMLCompartment, constant)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setConstant(SBMLCompartment, constant)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(constant)) || (constant < 0) || (constant > 1))
    error(sprintf('Compartment_setConstant(SBMLCompartment, constant)\n%s', 'second argument must be either true (=1) or false (=0) representing whether the compartment is constant'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_setConstant(SBMLCompartment, constant)', 'no constant field in a level 1 model'));    
end;

SBMLCompartment.constant = constant;