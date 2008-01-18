function SBMLKineticLaw = KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)
%
%   KineticLaw_setTimeUnits 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) a string representing the timeUnits to be set
%
%             and returns 
%               the kineticLaw with the timeUnits set
%
%       SBMLKineticLaw = KineticLaw_setTimeUnits(SBMLKineticLaw, 'timeUnits')

%  Filename    :   KineticLaw_setTimeUnits.m
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
if (~isstruct(SBMLKineticLaw))
  error(sprintf('%s\n%s', ...
    'KineticLaw_setTimeUnits(SBMLKineticLaw, ..)', ...
    'first argument must be an SBML KineticLaw structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLKineticLaw);

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)', 'first argument must be an SBML kineticLaw structure'));
elseif (~ischar(timeUnits))
    error(sprintf('KineticLaw_setTimeUnits(SBMLKineticLaw, timeUnits)\n%s', 'second argument must be a string representing the timeUnits of the kineticLaw'));
end;

SBMLKineticLaw.timeUnits = timeUnits;
