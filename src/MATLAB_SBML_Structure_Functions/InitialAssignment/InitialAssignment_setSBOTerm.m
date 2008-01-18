function SBMLInitialAssignment = InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)
%
%   InitialAssignment_setSBOTerm 
%             takes  1) an SBMLInitialAssignment structure 
%             and    2) an integer representing the sboTerm to be set
%
%             and returns 
%               the InitialAssignment with the sboTerm set
%
%       SBMLInitialAssignment = InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)

%  Filename    :   InitialAssignment_setSBOTerm.m
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
      'InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)', ...
      'argument must be an SBML InitialAssignment structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLInitialAssignment);

if (~isSBML_InitialAssignment(SBMLInitialAssignment, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)', ...
    'first argument must be an SBML InitialAssignment structure'));
elseif (~isIntegralNumber(sboTerm))
    error(sprintf('%s\n%s', ...
      'InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)', ...
      'second argument must be an integer representing the sboTerm'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'InitialAssignment_setSBOTerm(SBMLInitialAssignment, sboTerm)',  ...
      'sboTerm field only in level 2 version 2/3 model'));    
end;

SBMLInitialAssignment.sboTerm = sboTerm;