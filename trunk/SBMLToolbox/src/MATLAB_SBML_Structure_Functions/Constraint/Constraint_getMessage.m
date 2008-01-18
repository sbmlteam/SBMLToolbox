function message = Constraint_getMessage(SBMLConstraint)
%
%   Constraint_getMessage 
%             takes an SBMLConstraint structure 
%
%             and returns 
%               the message of the Constraint as a string
%
%       message = Constraint_getMessage(SBMLConstraint)

%  Filename    :   Constraint_getMessage.m
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
if (~isstruct(SBMLConstraint))
    error(sprintf('%s\n%s', ...
      'Constraint_getMessage(SBMLConstraint)', ...
      'argument must be an SBML Constraint structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLConstraint);

if (~isSBML_Constraint(SBMLConstraint, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', ...
      'Constraint_getMessage(SBMLConstraint)', ...
      'argument must be an SBML Constraint structure'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'Constraint_getMessage(SBMLConstraint)', ...
      'message field only in level 2 version 2/3 model'));    
end;

message = SBMLConstraint.message;
