function KineticLaw = KineticLaw_create(varargin)
%
%   KineticLaw_create 
%             optionally takes an SBML level 
%             optionally takes an SBML version
%
%             and returns 
%               a kineticLaw structure of the required level and version
%               (default level = 2 version = 3)
%
%       KineticLaw = KineticLaw_create
%    OR KineticLaw = KineticLaw_create(sbmlLevel)
%    OR KineticLaw = KineticLaw_create(sbmlLevel, sbmlVersion)

%  Filename    :   KineticLaw_create.m
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
    error(sprintf('%s\n%s\n%s', 'KineticLaw_create(sbmlLevel, sbmlVersion)', 'requires either zero, one or two arguments', 'SEE help KineticLaw_create'));

elseif (nargin == 2)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'KineticLaw_create(sbmlLevel, sbmlVersion)', 'first argument must be a valid SBML level i.e. either 1 or 2'));
    elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 3))
        error(sprintf('%s\n%s', 'KineticLaw_create(sbmlLevel, sbmlVersion)', 'second argument must be a valid SBML version i.e. either 1, 2 or 3'));
    end;
    sbmlLevel = varargin{1};
    if (sbmlLevel == 1 && varargin{2} == 3)
        error(sprintf('Level - version mismatch\nAllowed combinations are L1V1 L1V2 L2V1 L2V2 or L2V3'));
    else
        sbmlVersion = varargin{2};
    end;
    
elseif (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'KineticLaw_create(sbmlLevel)', 'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
    
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'formula', 'parameter', 'timeUnits', 'substanceUnits'};
    Values = {'SBML_KINETIC_LAW', '', '', '', [], '', ''};
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});
else
    if (sbmlVersion == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'formula', 'math', 'parameter', 'timeUnits', 'substanceUnits'};
        Values = {'SBML_KINETIC_LAW', '', '', '', '', '', [], '', ''};
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
    elseif (sbmlVersion == 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','formula', 'math','parameter', 'sboTerm'};
        Values = {'SBML_KINETIC_LAW', '', '', '', '', '', [], int32(-1)};
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'sboTerm', {}, 'isSetValue', {});
    elseif (sbmlVersion == 3)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', 'formula', 'math','parameter'};
        Values = {'SBML_KINETIC_LAW', '', '', '', int32(-1), '', '', []};
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, 'annotation', {}, 'sboTerm', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, 'constant', {}, 'isSetValue', {});
    end;
end;

KineticLaw = cell2struct(Values, SBMLfieldnames, 2);
KineticLaw = setfield(KineticLaw, 'parameter', parameter);

%check created structure is appropriate
if (~isSBML_KineticLaw(KineticLaw, sbmlLevel, sbmlVersion))
    KineticLaw = [];
    warning('Failed to create kineticLaw');
end;