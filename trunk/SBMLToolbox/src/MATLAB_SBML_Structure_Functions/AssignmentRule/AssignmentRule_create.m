function AssignmentRule = AssignmentRule_create(varargin)
%
%   AssignmentRule_create 
%             optionally takes an SBML level (which must be 2)
%             optionally takes an SBML version
%
%             and returns 
%               a assignmentRule structure of the required level and version
%               (default level = 2 version = 4)
%
%       AssignmentRule = AssignmentRule_create
%    OR AssignmentRule = AssignmentRule_create(sbmlLevel)
%    OR AssignmentRule = AssignmentRule_create(sbmlLevel, sbmlVersion)

%  Filename    :   AssignmentRule_create.m
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



%default level = 2
%default version = 4
sbmlLevel = 2;
sbmlVersion = 4;
if (nargin > 2)
  error(sprintf('%s\n%s\n%s', ...
    'AssignmentRule_create(sbmlLevel, sbmlVersion)', ...
    'requires either zero, one or two arguments', ...
    'SEE help AssignmentRule_create'));

elseif (nargin == 2)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'AssignmentRule_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be 2'));
  elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 4))
    error(sprintf('%s\n%s', 'AssignmentRule_create(sbmlLevel, sbmlVersion)', ...
      'second argument must be a valid SBML version i.e. either 1, 2, 3 or 4'));
  end;
  sbmlVersion = varargin{2};
    
elseif (nargin == 1)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'AssignmentRule_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be 2'));
  end;
    
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', ...
      'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ASSIGNMENT_RULE', '', '', '', '', '', '', '', '', ''};
else
  if (sbmlVersion == 1)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'formula', ...
      'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ASSIGNMENT_RULE','', '', '', '', '', '', '', '', ''};
  elseif (sbmlVersion == 2)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
      'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ASSIGNMENT_RULE', '', '', '', int32(-1), '', '', '', '', '', ''};
  elseif (sbmlVersion > 2)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
      'formula', 'variable', 'species', 'compartment', 'name', 'units'};
    Values = {'SBML_ASSIGNMENT_RULE','','', '', int32(-1), '', '', '', '', '', ''};
  end;
end;

AssignmentRule = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_AssignmentRule(AssignmentRule, sbmlLevel, sbmlVersion))
    AssignmentRule = [];
    warning('Failed to create assignmentRule');
end;
