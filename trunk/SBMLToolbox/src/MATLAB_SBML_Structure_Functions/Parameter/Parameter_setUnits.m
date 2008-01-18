function SBMLParameter = Parameter_setUnits(SBMLParameter, units)
%
%   Parameter_setUnits 
%             takes  1) an SBMLParameter structure 
%             and    2) a string representing the units to be set
%
%             and returns 
%               the parameter with the units set
%
%       SBMLParameter = Parameter_setUnits(SBMLParameter, 'units')

%  Filename    :   Parameter_setUnits.m
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
if (~isstruct(SBMLParameter))
  error(sprintf('%s\n%s', ...
    'Parameter_setUnits(SBMLParameter)', ...
    'first argument must be an SBML Parameter structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLParameter);

if (~isSBML_Parameter(SBMLParameter, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Parameter_setUnits(SBMLParameter, units)', 'first argument must be an SBML parameter structure'));
elseif (~ischar(units))
    error(sprintf('Parameter_setUnits(SBMLParameter, units)\n%s', 'second argument must be a string representing the units of the parameter'));
end;

SBMLParameter.units = units;
