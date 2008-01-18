function SBMLRule = Rule_setFormula(SBMLRule, formula)
%
%   Rule_setFormula 
%             takes  1) an SBMLRule structure 
%             and    2) a string representing the formula to be set
%
%             and returns 
%               the rule with the formula set
%
%       SBMLRule = Rule_setFormula(SBMLRule, 'formula')

%  Filename    :   Rule_setFormula.m
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
if (~isstruct(SBMLRule))
  error(sprintf('%s', ...
    'first argument must be an SBML Rule structure'));
end;
 
[sbmlLevel, sbmlVersion] = GetLevelVersion(SBMLRule);

if (~isSBML_Rule(SBMLRule, sbmlLevel, sbmlVersion))
    error(sprintf('%s\n%s', 'Rule_setFormula(SBMLRule, formula)', 'first argument must be an SBML rule structure'));
elseif (~ischar(formula))
    error(sprintf('Rule_setFormula(SBMLRule, formula)\n%s', 'second argument must be a string representing the formula of the rule'));
end;

SBMLRule.formula = formula;
