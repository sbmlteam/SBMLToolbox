function GeneProductAssociation = GeneProductAssociation_create(varargin)
% GeneProductAssociation = GeneProductAssociation_create(level, version, pkgVersion)
%
% Takes
%
% 1. level, an integer representing an SBML level
% 2. version, an integer representing an SBML version
% 3. pkgVersion, an integer representing an SBML package version
%
% Returns
%
% 1. a MATLAB_SBML FBC GeneProductAssociation structure of the appropriate level, version and pkgVersion
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


%check the input arguments are appropriate

if (nargin > 3)
	error('wrong number of input arguments');
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

if ~isValidFBCLevelVersionCombination(level, version, pkgVersion)
	GeneProductAssociation = [];
	warning('Warn:InvalidLV', 'GeneProductAssociation not an element in SBML L%dV%d Fbc V%d', level, version, pkgVersion);
elseif pkgVersion == 1
	GeneProductAssociation = [];
	warning('Warn:InvalidLV', 'GeneProductAssociation not an element in SBML L%dV%d Fbc V%d', level, version, pkgVersion);
end;

%get fields and values and create the structure

[fieldnames, num] = getGeneProductAssociationFieldnames(level, version, pkgVersion);
if (num > 0)
	values = getGeneProductAssociationDefaultValues(level, version, pkgVersion);
	GeneProductAssociation = cell2struct(values, fieldnames, 2);

%check correct structure

	if ~isSBML_FBC_GeneProductAssociation(GeneProductAssociation, level, version, pkgVersion)
		GeneProductAssociation = struct();
		warning('Warn:BadStruct', 'Failed to create GeneProductAssociation');
	end;

else
	GeneProductAssociation = [];
	warning('Warn:InvalidLV', 'GeneProductAssociation not an element in SBML L%dV%d Fbc V%d', level, version, pkgVersion);
end;

