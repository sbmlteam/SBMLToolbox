function SBMLFBCModel = FBCModel_addObjective(SBMLFBCModel, SBMLObjective)
% SBMLFBCModel = FBCModel_addObjective(SBMLFBCModel, SBMLObjective)
%
% Takes
%
% 1. SBMLFBCModel, an SBML FBCModel structure
% 2. SBMLObjective, an SBML Objective structure
%
% Returns
%
% 1. the SBML FBCModel structure with the SBML Objective structure added
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
[objective_level, objective_version, objective_pkgVersion] = GetFBCLevelVersion(SBMLObjective);

if level ~= objective_level
	error('mismatch in levels');
elseif version ~= objective_version
	error('mismatch in versions');
elseif pkgVersion ~= objective_pkgVersion
	error('mismatch in package versions');
end;

if isfield(SBMLFBCModel, 'fbc_objective')
	index = length(SBMLFBCModel.fbc_objective);
	if index == 0
		SBMLFBCModel.fbc_objective = SBMLObjective;
	else
		SBMLFBCModel.fbc_objective(index+1) = SBMLObjective;
	end;
else
	error('objective not an element on SBML L%dV%d FBCModel', level, version);
end;

