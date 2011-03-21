function InitialAssignment = InitialAssignment_create(varargin)
%
%   InitialAssignment_create 
%             optionally takes an SBML level
%             optionally takes an SBML version
%
%             and returns 
%               a InitialAssignment structure of the required level and version
%               (default level = 2 version = 4)
%
%       InitialAssignment = InitialAssignment_create
%    OR InitialAssignment = InitialAssignment_create(sbmlLevel)
%    OR InitialAssignment = InitialAssignment_create(sbmlLevel, sbmlVersion)

%  Filename    :   InitialAssignment_create.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
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



%default level = 2
%default version = 4
sbmlLevel = 2;
sbmlVersion = 4;

if (nargin > 2)
  error(sprintf('%s\n%s\n%s', ...
    'InitialAssignment_create(sbmlLevel, sbmlVersion)', ...
    'requires either zero, one or two arguments', ...
    'SEE help InitialAssignment_create'));

elseif (nargin == 2)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'InitialAssignment_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be SBML level 2'));
  elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 2) || (varargin{2} > 4))
    error(sprintf('%s\n%s', 'InitialAssignment_create(sbmlLevel, sbmlVersion)', ...
      'second argument must be a valid SBML version i.e. either 2, 3 or 4'));
  end;
  
  sbmlVersion = varargin{2};
    
elseif (nargin == 1)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'InitialAssignment_create(sbmlLevel)', ...
      'argument must be SBML level 2'));
  end;
end;

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;

if (sbmlVersion == 2)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
    'symbol', 'math'};
  Values = {'SBML_INITIAL_ASSIGNMENT', '', '', '', int32(-1), '', ''};
elseif (sbmlVersion > 2)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'symbol', ...
    'sboTerm', 'math'};
  Values = {'SBML_INITIAL_ASSIGNMENT', '', '', '', '', int32(-1), ''};
end;

InitialAssignment = cell2struct(Values, SBMLfieldnames, 2);

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;

%check created structure is appropriate
if (~isSBML_InitialAssignment(InitialAssignment, sbmlLevel, sbmlVersion))
    InitialAssignment = [];
    warning('Failed to create InitialAssignment');
end;
