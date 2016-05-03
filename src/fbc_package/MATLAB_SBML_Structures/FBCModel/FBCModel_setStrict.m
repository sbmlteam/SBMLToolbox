function SBMLFBCModel = FBCModel_setStrict(SBMLFBCModel, strict)
% SBMLFBCModel = FBCModel_setStrict(SBMLFBCModel, strict)
%
% Takes
%
% 1. SBMLFBCModel, an SBML FBCModel structure
% 2. strict, an integer(0/1) representing the fbc_strict to be set
%
% Returns
%
% 1. the SBML FBC FBCModel structure with the new value for the fbc_strict attribute
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

[level, version, pkgVersion] = GetFBCLevelVersion(SBMLFBCModel);

if ischar(strict)
    temp = str2num(strict);
    strict = temp;
end;
if isfield(SBMLFBCModel, 'fbc_strict')
	if (~isIntegralNumber(strict) || strict < 0 || strict > 1)
		error('strict must be an integer of value 0/1') ;
	else
		SBMLFBCModel.fbc_strict = strict;
	end;
else
	error('strict not an attribute on SBML L%dV%d FBCModel', level, version);
end;

