function rule = Model_getRateRuleByVariable(SBMLModel, variable)
%
%   Model_getRateRuleByVariable 
%             takes  1) an SBMLModel structure 
%             and    2) a string variable
%
%             and returns 
%               the assignment rule structure defined within the model
%               that assigns value to the variable given
%
%       rule = Model_getRateRuleByVariable(SBMLModel, variable)

%  Filename    :   Model_getRateRuleByVariable.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id:  Exp $
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->



% check that input is correct
if (~isSBML_Model(SBMLModel))
    error(sprintf('%s\n%s', 'Model_getRateRuleByVariable(SBMLModel, variable)', 'first argument must be an SBML model structure'));
elseif (~ischar(variable))
    error(sprintf('%s\n%s', 'Model_getRateRuleByVariable(SBMLModel, variable)', 'second argument must be a string'));
end;

rule = [];

% get level and version
sbmlLevel = SBMLModel.SBML_level;
sbmlVersion = SBMLModel.SBML_version;

for i = 1:length(SBMLModel.rule)
  if (isSBML_RateRule(SBMLModel.rule(i), sbmlLevel, sbmlVersion))
    if (strcmp(variable, RateRule_getVariable(SBMLModel.rule(i))))
      rule = SBMLModel.rule(i);
        break;
    end;
  end;
end;

%if level and version fields are not on returned object add them
if ~isfield(rule, 'level')
  rule.level = SBMLModel.SBML_level;
  rule.version = SBMLModel.SBML_version;
end;
