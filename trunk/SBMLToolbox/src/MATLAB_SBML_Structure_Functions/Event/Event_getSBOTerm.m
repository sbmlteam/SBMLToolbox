function sboTerm = Event_getSBOTerm(SBMLEvent)
%
%   Event_getSBOTerm 
%             takes an SBMLEvent structure 
%
%             and returns 
%               the sboTerm of the compartment as an integer
%
%       sboTerm = Event_getSBOTerm(SBMLEvent)

%  Filename    :   Event_getSBOTerm.m
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
    'Event_setSBOTerm(SBMLEvent, sboTerm)', ...
    'first argument must be an SBML event structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLEvent);

if (~isSBML_Event(SBMLEvent, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', ...
      'Event_getSBOTerm(SBMLEvent)', ...
      'argument must be an SBML event structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'Event_getSBOTerm(SBMLEvent)', ...
      'sboTerm field only in level 2 version 2/3 model'));    
end;

sboTerm = SBMLEvent.sboTerm;
