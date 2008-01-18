function ParameterRule = ParameterRule_create()
%
%   ParameterRule_create 
%
%             and returns 
%               a parameterRule structure (level 1 ONLY)
%
%       ParameterRule = ParameterRule_create

%  Filename    :   ParameterRule_create.m
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



%default level = 1
sbmlLevel = 1;
if (nargin > 0)
    error(sprintf('%s\n%s\n%s', 'ParameterRule_create()', ...
      'requires no arguments', 'SEE help ParameterRule_create'));
end;

SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', ...
  'variable', 'species', 'compartment', 'name', 'units'};
Values = {'SBML_PARAMETER_RULE', '', '', '', '', '', '', '', '', ''};

ParameterRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_ParameterRule(ParameterRule, sbmlLevel))
    ParameterRule = [];
    warning('Failed to create parameterRule');
end;
