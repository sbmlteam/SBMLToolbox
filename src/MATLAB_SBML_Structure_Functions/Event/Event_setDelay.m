function SBMLEvent = Event_setDelay(SBMLEvent, delay)
%
% Event_setDelay
%       takes an SBML Event structure
%    and the delay to be set
%
%       and returns
%           the Event with the new value for the delay attribute

%  Filename    :   Event_setDelay.m
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

[level, version] = GetLevelVersion(SBMLEvent);
if isstruct(delay)
  [delay_level, delay_version] = GetLevelVersion(delay);

  if level ~= delay_level
    error('mismatch in levels');
  elseif version ~= delay_version
    error('mismatch in versions');
  end;
end;

if isfield(SBMLEvent, 'delay')
	if (level == 2 && version < 3) && ~ischar(delay)
		error('delay must be character array') ;
  elseif (((level == 2 && version > 2) || level > 2) ...
      && ~isValid(delay, level, version))
    error('delay must be an SBML Delay structure');
  else
		SBMLEvent.delay = delay;
	end;
else
	error('delay not an attribute on SBML L%dV%d Event', level, version);
end;

