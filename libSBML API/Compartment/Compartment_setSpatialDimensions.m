function SBMLCompartment = Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)
%
%   Compartment_setSpatialDimensions 
%             takes  1) an SBMLCompartment structure 
%             and    2) an integer representing the spatialDimensions to be set
%
%             and returns 
%               the compartment with the spatialDimensions set
%
%       SBMLCompartment = Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(spatialDimensions)) || (spatialDimensions < 0) || (spatialDimensions > 3))
    error(sprintf('Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)\n%s', 'second argument must be an integer between 0 and 3 representing the spatial dimensions of the compartment'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)', 'no spatialDimensions field in a level 1 model'));    
end;

SBMLCompartment.spatialDimensions = spatialDimensions;