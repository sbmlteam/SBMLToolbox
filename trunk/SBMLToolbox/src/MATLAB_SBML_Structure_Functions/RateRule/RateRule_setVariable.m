function SBMLRateRule = RateRule_setVariable(SBMLRateRule, variable)
%
%   RateRule_setVariable 
%             takes  1) an SBMLRateRule structure 
%             and    2) a string representing the variable to be set
%
%             and returns 
%               the rateRule with the variable set
%
%       SBMLRateRule = RateRule_setVariable(SBMLRateRule, 'variable')

%  Filename    :   RateRule_setVariable.m
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
if (~isstruct(SBMLRateRule))
  error(sprintf('%s\n%s', ...
    'RateRule_setVariable(SBMLRateRule)', ...
    'first argument must be an SBML RateRule structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLRateRule);

if (~isSBML_RateRule(SBMLRateRule, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'RateRule_setVariable(SBMLRateRule, variable)', 'first argument must be an SBML rateRule structure'));
elseif (~ischar(variable))
    error(sprintf('RateRule_setVariable(SBMLRateRule, variable)\n%s', 'second argument must be a string representing the variable of the rateRule'));
end;

SBMLRateRule.variable = variable;
