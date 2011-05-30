function SBMLModel = Model_addSpeciesType(SBMLModel, SBMLSpeciesType)
%
% Model_addSpeciesType(SBMLModel, SBMLSpeciesType)
%       takes an SBML Model structure
%    and an SBML SpeciesType structure
%
%       and returns
%           the Model with the SpeciesType element added

%  Filename    :   Model_addSpeciesType.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
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


%get level and version and check the input arguments are appropriate

[level, version] = GetLevelVersion(SBMLModel);
[speciesType_level, speciesType_version] = GetLevelVersion(SBMLSpeciesType);

if level ~= speciesType_level
	error('mismatch in levels');
elseif version ~= speciesType_version
	error('mismatch in versions');
end;

if isfield(SBMLModel, 'speciesType')
	index = length(SBMLModel.speciesType);
	if index == 0
		SBMLModel.speciesType = SBMLSpeciesType;
	else
		SBMLModel.speciesType(index+1) = SBMLSpeciesType;
	end;
else
	error('speciesType not an element on SBML L%dV%d Model', level, version);
end;

