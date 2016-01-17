function event = Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)
%
%   Event_addEventAssignment 
%             takes  1) an SBMLEvent structure 
%             and    2) an SBMLEventAssignment structure
%
%             and returns 
%               the event with the eventAssignment added
%
%       event = Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)

%  Filename    :   Event_addEventAssignment.m
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
      'Event_addEventAssignment(SBMLEvent, sboTerm)', ...
      'argument must be an SBML Constraint structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLEvent);

if (~isSBML_Event(SBMLEvent, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'first argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2)
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'no events in level 1 model'));
elseif (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Event_addEventAssignment(SBMLEvent, SBMLEventAssignment)', 'second argument must be an SBML eventAssignment structure'));
end;

numberEventAssignments = length(SBMLEvent.eventAssignment);

SBMLEvent.eventAssignment(numberEventAssignments+1) = SBMLEventAssignment;

event = SBMLEvent;

