function FluxBound = FluxBound_create(varargin)
%
% FluxBound_create
%    takes an SBML level (optional)
%    and   an SBML version (optional)
%
%    returns
%      an MATLAB_SBML FluxBound structure of the appropriate
%           level and version
%
% NOTE: the optional level and version preserve backwards compatability
%         if version is missing the default values will be L1V2; L2V4 or L3V1
%         if neither argument is supplied the default values will be L3V1

%  Filename    :   FluxBound_create.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: $
%  $Source v $
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


%check the input arguments are appropriate

if (nargin > 3)
	error('too many input arguments');
end;

switch (nargin)
  case 3
		level = varargin{1};
		version = varargin{2};
    pkgVersion = varargin{3};
	case 2
		level = varargin{1};
		version = varargin{2};
    pkgVersion = 1;
	case 1
		level = varargin{1};
		if (level == 1)
			version = 2;
		elseif (level == 2)
			version = 4;
		else
			version = 1;
		end;
    pkgVersion = 1;
	otherwise
		level = 3;
		version = 1;
    pkgVersion = 1;
end;

if ~isValidLevelVersionCombination(level, version)
	error('invalid level/version combination');
end;

%get fields and values and create the structure

[fieldnames, num] = getFluxBoundFieldnames(level, version, pkgVersion);
if (num > 0)
	values = getFluxBoundDefaultValues(level, version, pkgVersion);
	FluxBound = cell2struct(values, fieldnames, 2);

	%add level and version

	FluxBound.level = level;
	FluxBound.version = version;
  FluxBound.fbc_version = pkgVersion;

%check correct structure

	if ~isSBML_FBC_FluxBound(FluxBound, level, version, pkgVersion)
		FluxBound = struct();
		warning('Warn:BadStruct', 'Failed to create FluxBound');
	end;

else
	FluxBound = [];
	warning('Warn:InvalidLV', 'FluxBound not an element in SBML L%dV%d', level, version);
end;

