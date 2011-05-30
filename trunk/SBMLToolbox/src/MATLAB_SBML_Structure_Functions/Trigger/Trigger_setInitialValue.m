function SBMLTrigger = Trigger_setInitialValue(SBMLTrigger, initialValue)
%
% Trigger_setInitialValue
%       takes an SBML Trigger structure
%    and the initialValue to be set
%
%       and returns
%           the Trigger with the new value for the initialValue attribute

%  Filename    :   Trigger_setInitialValue.m
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

[level, version] = GetLevelVersion(SBMLTrigger);

if isfield(SBMLTrigger, 'initialValue')
	if (~isIntegralNumber(initialValue) || initialValue < 0 || initialValue > 1)
		error('initialValue must be an integer of value 0/1') ;
	else
		SBMLTrigger.initialValue = initialValue;
	end;
else
	error('initialValue not an attribute on SBML L%dV%d Trigger', level, version);
end;

