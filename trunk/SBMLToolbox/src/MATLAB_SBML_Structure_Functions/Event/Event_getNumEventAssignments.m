function number = Event_getNumEventAssignments(SBMLEvent)
%
%   Event_getNumEventAssignments 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the number of eventAssignment structures defined within the event
%
%       number = Event_getNumEventAssignments(SBMLEvent)

%  Filename    :   Event_getNumEventAssignments.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isstruct(SBMLEvent))
    error(sprintf('%s\n%s', ...
      'Event_getNumEventAssignments(SBMLEvent)', ...
      'argument must be an SBML Constraint structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLEvent);

if (~isSBML_Event(SBMLEvent, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Event_getNumEventAssignments(SBMLEvent)', 'argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_getNumEventAssignments(SBMLEvent)', 'no events in a level 1 model'));   
end;

number = 0;

if (~isempty(SBMLEvent.eventAssignment))
    number = length(SBMLEvent.eventAssignment);
end;
