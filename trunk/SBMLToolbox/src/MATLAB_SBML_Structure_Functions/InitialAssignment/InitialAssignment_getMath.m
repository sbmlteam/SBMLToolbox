function math = InitialAssignment_getMath(SBMLInitialAssignment)
%
%   InitialAssignment_getMath 
%             takes an SBMLInitialAssignment structure 
%
%             and returns 
%               the math of the InitialAssignment as a string
%
%       math = InitialAssignment_getMath(SBMLInitialAssignment)

%  Filename    :   InitialAssignment_getMath.m
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
if (~isstruct(SBMLInitialAssignment))
    error(sprintf('%s\n%s', ...
      'InitialAssignment_getMath(SBMLInitialAssignment)', ...
      'argument must be an SBML InitialAssignment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLInitialAssignment);

if (~isSBML_InitialAssignment(SBMLInitialAssignment, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', ...
      'InitialAssignment_getMath(SBMLInitialAssignment)', ...
      'argument must be an SBML InitialAssignment structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'InitialAssignment_getMath(SBMLInitialAssignment)', ...
      'math field only in level 2 version 2/3 model'));    
end;

math = SBMLInitialAssignment.math;
