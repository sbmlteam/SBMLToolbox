function StoichiometryMath = StoichiometryMath_create(varargin)
%
%   StoichiometryMath_create 
%             optionally takes an SBML level
%             optionally takes an SBML version
%
%             and returns 
%               a StoichiometryMath structure of the required level and version
%               (default level = 2 version = 3)
%
%       StoichiometryMath = StoichiometryMath_create
%    OR StoichiometryMath = StoichiometryMath_create(sbmlLevel)
%    OR StoichiometryMath = StoichiometryMath_create(sbmlLevel, sbmlVersion)

%  Filename    :   StoichiometryMath_create.m
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
%default version = 3
sbmlLevel = 2;
sbmlVersion = 3;

if (nargin > 2)
  error(sprintf('%s\n%s\n%s', ...
    'StoichiometryMath_create(sbmlLevel, sbmlVersion)', ...
    'requires either zero, one or two arguments', ...
    'SEE help StoichiometryMath_create'));

elseif (nargin == 2)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'StoichiometryMath_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be SBML level 2'));
  elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 2) || (varargin{2} > 3))
    error(sprintf('%s\n%s', 'StoichiometryMath_create(sbmlLevel, sbmlVersion)', ...
      'second argument must be a valid SBML version in this case 3'));
  end;
  
  sbmlVersion = varargin{2};
    
elseif (nargin == 1)
  if ((~isIntegralNumber(varargin{1})) || (varargin{1} ~= 2))
    error(sprintf('%s\n%s', 'StoichiometryMath_create(sbmlLevel)', ...
      'argument must be SBML level 2'));
  end;
end;

warning off all;
if (sbmlVersion == 3)
  SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', 'math'};
  Values = {'SBML_INITIAL_ASSIGNMENT', '', '', '', int32(-1), ''};
end;

StoichiometryMath = cell2struct(Values, SBMLfieldnames, 2);
warning on all;

%check created structure is appropriate
if (~isSBML_StoichiometryMath(StoichiometryMath, sbmlLevel, sbmlVersion))
    StoichiometryMath = [];
    warning('Failed to create StoichiometryMath');
end;
