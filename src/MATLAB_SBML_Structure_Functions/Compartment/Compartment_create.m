function Compartment = Compartment_create(varargin)
%
%   Compartment_create 
%             optionally takes an SBML level
%             optionally takes an SBML version
%
%             and returns 
%               a compartment structure of the required level and version
%               (default level = 2 version = 4)
%
%       Compartment = Compartment_create
%    OR Compartment = Compartment_create(sbmlLevel)
%    OR Compartment = Compartment_create(sbmlLevel, sbmlVersion)

%  Filename    :   Compartment_create.m
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
      'Compartment_create(sbmlLevel, sbmlVersion)', ...
      'requires either zero, one or two arguments', ...
      'SEE help Compartment_create'));

elseif (nargin == 2)
    if ((~isIntegralNumber(varargin{1})) ...
        || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', ...
          'Compartment_create(sbmlLevel, sbmlVersion)', ...
          'first argument must be a valid SBML level i.e. either 1 or 2'));
    elseif ((~isIntegralNumber(varargin{2})) ...
        || (varargin{2} < 1) || (varargin{2} > 4))
        error(sprintf('%s\n%s', ...
          'Compartment_create(sbmlLevel, sbmlVersion)', ...
          'second argument must be a valid SBML version i.e. either 1, 2, 3 or 4'));
    end;
    sbmlLevel = varargin{1};
    if (sbmlLevel == 1 && varargin{2} > 2)
        error(sprintf('%s\n%s', ...
          'Level - version mismatch', ...
          'Allowed combinations are L1V1 L1V2 L2V1 L2V2 L2V3 or L2V4'));
    else
        sbmlVersion = varargin{2};
    end;
    
elseif (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) ...
        || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Compartment_create(sbmlLevel)', ...
          'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
    
end;

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'volume', ...
      'units', 'outside', 'isSetVolume' };
    Values = {'SBML_COMPARTMENT', '', '', '', 1, '', '', int32(1)};
else
    if (sbmlVersion == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'name', 'id', 'spatialDimensions', ...
            'size', 'units', 'outside', 'constant', 'isSetSize','isSetVolume'};
        Values = {'SBML_COMPARTMENT','','', '', '', '',int32(3), 0/0, ...
          '', '', int32(1), int32(0), int32(0)};
    elseif (sbmlVersion == 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'name', 'id', 'compartmentType', 'spatialDimensions', 'size', ...
          'units', 'outside', 'constant', 'isSetSize','isSetVolume'};
        Values = {'SBML_COMPARTMENT','', '', '', '', '', '', int32(3), 0/0, ...
          '', '', int32(1), int32(0), int32(0)};
    elseif (sbmlVersion > 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'sboTerm', 'name', 'id', 'compartmentType', 'spatialDimensions', ...
          'size', 'units', 'outside', 'constant', 'isSetSize','isSetVolume'};
        Values = {'SBML_COMPARTMENT','', '', '', int32(-1), '', '', '', ...
          int32(3), 0/0, '', '', int32(1), int32(0), int32(0)};
    end;
end;

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;

Compartment = cell2struct(Values, SBMLfieldnames, 2);

%check created structure is appropriate
if (~isSBML_Compartment(Compartment, sbmlLevel, sbmlVersion))
    Compartment = [];
    warning('Failed to create compartment');
end;
