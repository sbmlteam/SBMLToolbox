function [level, version, pkgVersion] = GetFBCLevelVersion(SBMLStructure)
% [level, version, pkgVersion] = GetFBCLevelVersion(SBMLStructure) 
% 
% Takes 
% 
% 1. SBMLStructure, any SBML structure
% 
% Returns 
% 
% 1. the SBML level corresponding to this structure
% 2. the SBML version corresponding to this structure
% 3. the FBC package version corresponding to this structure
%
% *NOTE:* it is not always possible to uniquely determine the level/version from a
% structure. The most recent SBML level/version that matches will be reported.

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


if ~isfield(SBMLStructure, 'fbc_version')
    [level, version, pkgVersion] = GetFBCLevelVersion(SBMLStructure);
    pkgVersion = 0;
else
    level = 3;
    version = 1;
    pkgVersion = SBMLStructure.fbc_version;
end;

if ~isValid(SBMLStructure, level, version, pkgVersion)
    error('GetFBCLevelVersion - argument must be a valid structure');
end;