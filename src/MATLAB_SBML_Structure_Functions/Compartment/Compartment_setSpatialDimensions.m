function SBMLCompartment = Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)
% SBMLCompartment = Compartment_setSpatialDimensions(SBMLCompartment, spatialDimensions)
%
% takes
%
% 1. SBMLCompartment; an SBML Compartment structure
% 2. spatialDimensions; number representing the value of spatialDimensions to be set
%
% returns
%
% 1. the SBML Compartment structure with the new value for the spatialDimensions attribute
%

%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->
























%get level and version and check the input arguments are appropriate

[level, version] = GetLevelVersion(SBMLCompartment);

if isfield(SBMLCompartment, 'spatialDimensions')
	if (level > 2 && ~isnumeric(spatialDimensions))
		error('spatialDimensions must be numeric') ;
  elseif (level < 3 && (~isIntegralNumber(spatialDimensions) ...
      || spatialDimensions < 0 || spatialDimensions > 3))
    error('spatialDimensions must be integer values 0, 1, 2, or 3');
	else
		SBMLCompartment.spatialDimensions = spatialDimensions;
    if (isfield(SBMLCompartment, 'isSetSpatialDimensions'))
      SBMLCompartment.isSetSpatialDimensions = 1;
    end;
	end;
else
	error('spatialDimensions not an attribute on SBML L%dV%d Compartment', level, version);
end;

