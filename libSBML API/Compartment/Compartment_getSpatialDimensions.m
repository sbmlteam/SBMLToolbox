function spatialDimensions = Compartment_getSpatialDimensions(SBMLCompartment)
%
%   Compartment_getSpatialDimensions 
%             takes an SBMLCompartment structure 
%
%             and returns 
%               the spatial dimensions of the compartment as an integer
%
%       spatialDimensions = Compartment_getSpatialDimensions(SBMLCompartment)

% check that input is correct
sbmlLevel = 1;
if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    sbmlLevel = 2;
end;

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel))
    error(sprintf('%s\n%s', 'Compartment_getSpatialDimensions(SBMLCompartment)', 'argument must be an SBML compartment structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_getSpatialDimensions(SBMLCompartment)', 'no spatialDimensions field in a level 1 model'));    
end;

spatialDimensions = SBMLCompartment.spatialDimensions;