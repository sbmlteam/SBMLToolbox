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

%  Filename    :   Compartment_setSpatialDimensions.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isstruct(SBMLCompartment))
    error(sprintf('%s\n%s', ...
      'Compartment_setSpatialDimensions(SBMLCompartment)', ...
      'argument must be an SBML compartment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLCompartment);

if (~isSBML_Compartment(SBMLCompartment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)', 'first argument must be an SBML model structure'));
elseif ((~isIntegralNumber(spatialDimensions)) || (spatialDimensions < 0) || (spatialDimensions > 3))
    error(sprintf('Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)\n%s', 'second argument must be an integer between 0 and 3 representing the spatial dimensions of the compartment'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)', 'no spatialDimensions field in a level 1 model'));    
end;

SBMLCompartment.spatialDimensions = int32(spatialDimensions);
