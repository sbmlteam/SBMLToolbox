function Reaction = Reaction_create(varargin)
%
%   Reaction_create 
%             optionally takes an SBML level 
%             optionally takes an SBML version
%
%             and returns 
%               a reaction structure of the required level and version
%               (default level = 2 version = 4)
%
%       Reaction = Reaction_create
%    OR Reaction = Reaction_create(sbmlLevel)
%    OR Reaction = Reaction_create(sbmlLevel, sbmlVersion)

%  Filename    :   Reaction_create.m
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
    error(sprintf('%s\n%s\n%s', 'Reaction_create(sbmlLevel, sbmlVersion)', ...
      'requires either zero, one or two arguments', 'SEE help Reaction_create'));

elseif (nargin == 2)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Reaction_create(sbmlLevel, sbmlVersion)', ...
          'first argument must be a valid SBML level i.e. either 1 or 2'));
    elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 4))
        error(sprintf('%s\n%s', 'Reaction_create(sbmlLevel, sbmlVersion)', ...
          'second argument must be a valid SBML version i.e. either 1, 2, 3 or 4'));
    end;
    sbmlLevel = varargin{1};
    if (sbmlLevel == 1 && varargin{2} > 2)
        error(sprintf('%s\n%s', 'Level - version mismatch', ...
          'Allowed combinations are L1V1 L1V2 L2V1 L2V2 L2V3 or L2V4'));
    else
        sbmlVersion = varargin{2};
    end;
    
elseif (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'Reaction_create(sbmlLevel)', ...
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
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', ...
      'reactant', 'product', 'kineticLaw', 'reversible', 'fast' };
    Values = {'SBML_REACTION', '', '', '', [], [], [], int32(0),  int32(0)};
    reactant = struct('typecode', {}, 'notes', {}, 'annotation', {}, ...
      'species', {}, 'stoichiometry', {}, 'denominator', {});
    product = struct('typecode', {}, 'notes', {}, 'annotation', {}, ...
      'species', {}, 'stoichiometry', {}, 'denominator', {});
else
    if (sbmlVersion == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'name', 'id', 'reactant', 'product', 'modifier', 'kineticLaw', ...
          'reversible', 'fast', 'isSetFast' };
        Values = {'SBML_REACTION', '', '', '', '', '', [], [], [], [], ...
          int32(0),  int32(-1), int32(0)};
        reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {}, 'stoichiometry', {}, ...
          'denominator', {}, 'stoichiometryMath', {});
        product = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {}, 'stoichiometry', {}, ...
          'denominator', {}, 'stoichiometryMath', {});
        modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {});
    elseif (sbmlVersion == 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'name', 'id', 'reactant', 'product', 'modifier', 'kineticLaw', ...
          'reversible', 'fast', 'sboTerm', 'isSetFast'};
        Values = {'SBML_REACTION', '', '', '', '', '', [], [], [], [], ...
          int32(0),  int32(-1), int32(-1), int32(0)};
        reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {}, 'id', {}, 'name', {}, ...
            'sboTerm', {}, 'stoichiometry', {}, 'stoichiometryMath', {});
        product = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {}, 'id', {}, 'name', {}, ...
            'sboTerm', {}, 'stoichiometry', {}, 'stoichiometryMath', {});
        modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'species', {}, 'id', {}, 'name', {}, 'sboTerm', {});
    elseif (sbmlVersion > 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', ...
          'sboTerm', 'name', 'id', 'reactant', 'product', ...
            'modifier', 'kineticLaw', 'reversible', 'fast', 'isSetFast'};
        Values = {'SBML_REACTION', '', '', '', int32(-1), '', '', [], [], ...
          [], [], int32(0),  int32(-1), int32(0)};
        
        stoichiometryMath = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'math', {});
        reactant = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'species', {}, 'id', {}, 'name', {}, ...
            'stoichiometry', {}, 'stoichiometryMath', stoichiometryMath);

        product = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'species', {}, 'id', {}, 'name', {}, ...
            'stoichiometry', {}, 'stoichiometryMath', stoichiometryMath);
        modifier = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'species', {}, 'id', {}, 'name', {});
        
    end;
end;

Reaction = cell2struct(Values, SBMLfieldnames, 2);
Reaction = setfield(Reaction, 'product', product);
Reaction = setfield(Reaction, 'reactant', reactant);
if (sbmlLevel == 2)
    Reaction = setfield(Reaction, 'modifier', modifier);
end;
if (sbmlLevel == 1)
    parameter = struct('typecode', {}, 'notes', {}, 'annotation', {}, ...
      'name', {}, 'value', {}, 'units', {}, 'isSetValue', {});
    kineticLaw = struct('typecode', {}, 'notes', {}, 'annotation', {}, ...
      'formula', {}, 'parameter', parameter, 'timeUnits', {}, 'substanceUnits', {});
else
    if (sbmlVersion == 1)
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, ...
          'constant', {}, 'isSetValue', {});
        kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'formula', {}, 'math', {}, 'parameter', ...
          parameter, 'timeUnits', {}, 'substanceUnits', {});
    elseif (sbmlVersion == 2)
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'name', {}, 'id', {}, 'value', {}, 'units', {}, ...
          'constant', {}, 'sboTerm', {}, 'isSetValue', {});
        kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'formula', {}, 'math', {}, 'parameter', ...
          parameter, 'sboTerm', {});
    elseif (sbmlVersion > 2)
        parameter = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'name', {}, 'id', {}, 'value', ...
          {}, 'units', {}, 'constant', {}, 'isSetValue', {});
        kineticLaw = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'formula', {}, 'math', {}, ...
          'parameter', parameter);
    end;
end;

% kineticLaw = setfield(kineticLaw, 'parameter', parameter);
Reaction = setfield(Reaction, 'kineticLaw', kineticLaw);

if exist('OCTAVE_VERSION')
  warning off Octave:divide-by-zero;
else
  warning off MATLAB:divideByZero;
end;

%check created structure is appropriate
if (~isSBML_Reaction(Reaction, sbmlLevel, sbmlVersion))
    Reaction = [];
    warning('Failed to create reaction');
end;
