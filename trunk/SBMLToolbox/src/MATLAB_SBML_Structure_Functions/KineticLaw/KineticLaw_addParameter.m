function kineticLaw = KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)
%
%   KineticLaw_addParameter 
%             takes  1) an SBMLKineticLaw structure 
%             and    2) an SBMLParameter structure
%
%             and returns 
%               the kineticLaw with the parameter added
%
%       kineticLaw = KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)

%  Filename    :   KineticLaw_addParameter.m
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
    'KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)', ...
    'first argument must be an SBML KineticLaw structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLKineticLaw);

if (~isSBML_KineticLaw(SBMLKineticLaw, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)', 'first argument must be an SBML kineticLaw structure'));
elseif (~isSBML_Parameter(SBMLParameter, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s\nof the same SBML level, namely level %u', 'KineticLaw_addParameter(SBMLKineticLaw, SBMLParameter)', 'second argument must be an SBML parameter structure', sbmlLevel));
end;

numberParameters = length(SBMLKineticLaw.parameter);

SBMLKineticLaw.parameter(numberParameters+1) = SBMLParameter;

kineticLaw = SBMLKineticLaw;

