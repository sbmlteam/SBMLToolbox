function SBMLUnit = Unit_setExponent(SBMLUnit, exponent)
% SBMLUnit = Unit_setExponent(SBMLUnit, exponent)
%
% Takes
%
% 1. SBMLUnit, an SBML Unit structure
% 2. exponent; number representing the value of exponent to be set
%
% Returns
%
% 1. the SBML Unit structure with the new value for the exponent attribute
%

%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2016 jointly by the following organizations: 
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

[level, version] = GetLevelVersion(SBMLUnit);

if isfield(SBMLUnit, 'exponent')
  if level < 3
    if ~isIntegralNumber(exponent)
      error('exponent must be an integer') ;
    else
      SBMLUnit.exponent = exponent;
    end;
  else   
    if ~isnumeric(exponent)
      error('exponent must be numeric') ;
    else
      SBMLUnit.exponent = exponent;
    end;
  end;
else
	error('exponent not an attribute on SBML L%dV%d Unit', level, version);
end;

