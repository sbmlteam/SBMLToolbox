function SBMLParameter = Parameter_setValue(SBMLParameter, value)
%
%   Parameter_setValue 
%             takes  1) an SBMLParameter structure 
%             and    2) a double representing the value to be set
%
%             and returns 
%               the parameter with the value set
%
%       SBMLParameter = Parameter_setValue(SBMLParameter, value)

%  Filename    :   Parameter_setValue.m
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
    'Parameter_setValue(SBMLParameter)', ...
    'first argument must be an SBML Parameter structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLParameter);

if (~isSBML_Parameter(SBMLParameter, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Parameter_setValue(SBMLParameter, value)', 'first argument must be an SBML parameter structure'));
end;

SBMLParameter.value = value;
SBMLParameter.isSetValue = int32(1);
