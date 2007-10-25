function UnitDefinition = UnitDefinition_create(varargin)
%
%   UnitDefinition_create 
%             optionally takes an SBML level 
%             optionally takes an SBML version
%
%             and returns 
%               a unitDefinition structure of the required level and version
%               (default level = 2 version = 3)
%
%       UnitDefinition = UnitDefinition_create
%    OR UnitDefinition = UnitDefinition_create(sbmlLevel)
%    OR UnitDefinition = UnitDefinition_create(sbmlLevel, sbmlVersion)


%  Filename    :   UnitDefinition_create.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   09-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


%default level = 2
%default version = 3
sbmlLevel = 2;
sbmlVersion = 3;

if (nargin > 2)
  error(sprintf('%s\n%s\n%s', ...
    'UnitDefinition_create(sbmlLevel, sbmlVersion)', ...
    'requires either zero, one or two arguments', ...
    'SEE help UnitDefinition_create'));

elseif (nargin == 2)
  if ((~isIntegralNumber(varargin{1})) ...
      || (varargin{1} < 1) || (varargin{1} > 2))
    error(sprintf('%s\n%s', ...
      'UnitDefinition_create(sbmlLevel, sbmlVersion)', ...
      'first argument must be a valid SBML level i.e. either 1 or 2'));
  elseif ((~isIntegralNumber(varargin{2})) ...
      || (varargin{2} < 1) || (varargin{2} > 3))
    error(sprintf('%s\n%s', 'UnitDefinition_create(sbmlLevel, sbmlVersion)', ...
      'second argument must be a valid SBML version i.e. either 1, 2 or 3'));
  end;
  sbmlLevel = varargin{1};
  if (sbmlLevel == 1 && varargin{2} == 3)
    error(sprintf('%s\n%s', 'Level - version mismatch.', ...
      'Allowed combinations are L1V1 L1V2 L2V1 L2V2 or L2V3'));
  else
    sbmlVersion = varargin{2};
  end;
    
elseif (nargin == 1)
  if ((~isIntegralNumber(varargin{1})) ...
      || (varargin{1} < 1) || (varargin{1} > 2))
    error(sprintf('%s\n%s', 'UnitDefinition_create(sbmlLevel)', ...
      'argument must be a valid SBML level i.e. either 1 or 2'));
  end;
  sbmlLevel = varargin{1};

end;

warning off all;
if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, ...
      'exponent',{},  'scale', {})
else
  if (sbmlVersion == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, ...
      'exponent',{},  'scale', {}, 'multiplier', {}, 'offset',{});
  elseif (sbmlVersion == 2)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'kind', {}, ...
      'exponent',{},  'scale', {}, 'multiplier', {});
  elseif (sbmlVersion == 3)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'sboTerm', 'name', ...
      'id', 'unit'};
    Values = {'SBML_UNIT_DEFINITION', '', '', int32(-1), '', '', []};
    unit = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'sboTerm', ...
      {}, 'kind', {}, 'exponent',{},  'scale', {}, 'multiplier', {});
  end;
end;

UnitDefinition = cell2struct(Values, SBMLfieldnames, 2);
UnitDefinition = setfield(UnitDefinition, 'unit', unit);

warning on all;

%check created structure is appropriate
if (~isSBML_UnitDefinition(UnitDefinition, sbmlLevel, sbmlVersion))
    UnitDefinition = [];
    warning('Failed to create unitDefinition');
end;
