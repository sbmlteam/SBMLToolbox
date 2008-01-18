function math = EventAssignment_getMath(SBMLEventAssignment)
%
%   EventAssignment_getMath 
%             takes an SBMLEventAssignment structure 
%
%             and returns 
%               the math of the eventAssignment as a string
%
%       math = EventAssignment_getMath(SBMLEventAssignment)

%  Filename    :   EventAssignment_getMath.m
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
if (~isstruct(SBMLEventAssignment))
  error(sprintf('%s\n%s', ...
    'EventAssignment_getMath(SBMLEventAssignment)', ...
    'first argument must be an SBML eventAssignment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLEventAssignment);

if (~isSBML_EventAssignment(SBMLEventAssignment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'EventAssignment_getMath(SBMLEventAssignment)', 'argument must be an SBML eventAssignment structure'));
end;

math = SBMLEventAssignment.math;
