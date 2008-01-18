function timeUnits = KineticLaw_getTimeUnits(SBMLKineticLaw)
%
%   KineticLaw_getTimeUnits 
%             takes an SBMLKineticLaw structure 
%
%             and returns 
%               the timeUnits of the kineticLaw as a string
%
%       timeUnits = KineticLaw_getTimeUnits(SBMLKineticLaw)

%  Filename    :   KineticLaw_getTimeUnits.m
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
    'KineticLaw_getTimeUnits(SBMLKineticLaw)', ...
    'first argument must be an SBML KineticLaw structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLKineticLaw);

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'KineticLaw_getTimeUnits(SBMLKineticLaw)', 'argument must be an SBML kineticLaw structure'));
end;

timeUnits = SBMLKineticLaw.timeUnits;
