function Event = Event_create(varargin)
%
%   Event_create 
%             optionally takes an SBML level (which must be 2)
%             optionally takes an SBML version
%
%             returns 
%               an event structure of the required level and version
%               (default level = 2 version = 4)
%
%       Event = Event_create
%    OR Event = Event_create(sbmlLevel)
%    OR Event = Event_create(sbmlLevel, sbmlVersion)

%  Filename    :   Event_create.m
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



%default level = 2
%default version = 4
sbmlLevel = 2;
sbmlVersion = 4;
if (nargin > 2)
  error(sprintf('%s\n%s\n%s', ...
    'Event_create(sbmlLevel, sbmlVersion)', ...
    'requires either zero, one or two arguments', ...
    'SEE help Event_create'));

elseif (nargin == 2)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'Event_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be 2'));
  elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 4))
    error(sprintf('%s\n%s', 'Event_create(sbmlLevel, sbmlVersion)', ...
      'second argument must be a valid SBML version i.e. either 1, 2, 3 or 4'));
  end;
  sbmlVersion = varargin{2};
    
elseif (nargin == 1)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'Event_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be 2'));
  end;
    
end;

if (sbmlVersion == 1)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'name', 'id', ...
    'trigger', 'delay', 'timeUnits', 'eventAssignment'};
  Values = {'SBML_EVENT', '','', '', '', '', '', '', '', []};
  eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'variable', {}, 'math', {});
elseif (sbmlVersion == 2)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'name', 'id', ...
    'trigger', 'delay', 'timeUnits', 'sboTerm', 'eventAssignment'};
  Values = {'SBML_EVENT', '','', '', '', '', '', '', '', int32(-1), []};
  eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'variable', {}, 'sboTerm', [], 'math', {});
elseif (sbmlVersion == 3)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', 'name', ...
    'id', 'trigger', 'delay', 'eventAssignment'};
  Values = {'SBML_EVENT', '', '','', int32(-1), '', '', '', '', []};
  eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {}, 'variable', [], 'math', {});
  trigger = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {},  'math', {});
  delay = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {},  'math', {});
elseif (sbmlVersion == 4)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', 'name', ...
    'id', 'useValuesFromTriggerTime', 'trigger', 'delay', 'eventAssignment'};
  Values = {'SBML_EVENT', '', '','', int32(-1), '', '', '', '', '', []};
  eventAssignment = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {}, 'variable', [], 'math', {});
  trigger = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {},  'math', {});
  delay = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, ...
    'sboTerm', {},  'math', {});
end;

Event = cell2struct(Values, SBMLfieldnames, 2);
Event = setfield(Event, 'eventAssignment', eventAssignment);
if (sbmlVersion > 2)
  Event = setfield(Event, 'trigger', trigger);
  Event = setfield(Event, 'delay', delay);
end;

%check created structure is appropriate
if (~isSBML_Event(Event, sbmlLevel, sbmlVersion))
    Event = [];
    warning('Failed to create event');
end;
