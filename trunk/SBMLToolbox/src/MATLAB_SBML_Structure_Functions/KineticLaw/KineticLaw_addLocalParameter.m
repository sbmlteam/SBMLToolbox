function SBMLKineticLaw = KineticLaw_addLocalParameter(SBMLKineticLaw, SBMLLocalParameter)
%
% KineticLaw_addLocalParameter(SBMLKineticLaw, SBMLLocalParameter)
%    takes an SBML KineticLaw structure
%    and an SBML LocalParameter structure
%
%    returns
%      the KineticLaw with the LocalParameter element added

%  Filename    :   KineticLaw_addLocalParameter.m
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


%get level and version and check the input arguments are appropriate

[level, version] = GetLevelVersion(SBMLKineticLaw);
[localParameter_level, localParameter_version] = GetLevelVersion(SBMLLocalParameter);

if level ~= localParameter_level
	error('mismatch in levels');
elseif version ~= localParameter_version
	error('mismatch in versions');
end;

if isfield(SBMLKineticLaw, 'localParameter')
	index = length(SBMLKineticLaw.localParameter);
	if index == 0
		SBMLKineticLaw.localParameter = SBMLLocalParameter;
	else
		SBMLKineticLaw.localParameter(index+1) = SBMLLocalParameter;
	end;
else
	error('localParameter not an element on SBML L%dV%d KineticLaw', level, version);
end;

