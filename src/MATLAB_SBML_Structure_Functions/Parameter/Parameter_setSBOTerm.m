function SBMLParameter = Parameter_setSBOTerm(SBMLParameter, sboTerm)
%
%   Parameter_setSBOTerm 
%             takes  1) an SBMLParameter structure 
%             and    2) an integer representing the sboTerm to be set
%
%             and returns 
%               the compartment with the sboTerm set
%
%       SBMLParameter = Parameter_setSBOTerm(SBMLParameter, sboTerm)

%  Filename    :   Parameter_setSBOTerm.m
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
    'Parameter_setSBOTerm(SBMLParameter, sboTerm)', ...
    'first argument must be an SBML Parameter structure'));
end;

[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLParameter);

if (~isSBML_Parameter(SBMLParameter, sbmlLevel, sbmlVersion))
  error(sprintf('%s\n%s', ...
    'Parameter_setSBOTerm(SBMLParameter, sboTerm)', ...
    'first argument must be an SBML Parameter structure'));
elseif (~isIntegralNumber(sboTerm))
    error(sprintf('%s\n%s', ...
      'Parameter_setSBOTerm(SBMLParameter, sboTerm)', ...
      'second argument must be an integer representing the sboTerm'));
elseif (sbmlLevel ~= 2 || sbmlVersion == 1)
    error(sprintf('%s\n%s', ...
      'Parameter_setSBOTerm(SBMLParameter, sboTerm)',  ...
      'sboTerm field only in level 2 version 3 model'));    
end;

SBMLParameter.sboTerm = sboTerm;
