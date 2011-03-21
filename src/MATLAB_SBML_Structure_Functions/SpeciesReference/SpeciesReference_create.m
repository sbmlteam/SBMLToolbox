function SpeciesReference = SpeciesReference_create(varargin)
%
%   SpeciesReference_create 
%             optionally takes an SBML level 
%             optionally takes an SBML version
%
%             and returns 
%               a speciesReference structure of the required level and version
%               (default level = 2 version = 4)
%
%       SpeciesReference = SpeciesReference_create
%    OR SpeciesReference = SpeciesReference_create(sbmlLevel)
%    OR SpeciesReference = SpeciesReference_create(sbmlLevel, sbmlVersion)

%  Filename    :   SpeciesReference_create.m
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
      'SpeciesReference_create(sbmlLevel, sbmlVersion)', ...
      'requires either zero, one or two arguments', ...
      'SEE help SpeciesReference_create'));

elseif (nargin == 2)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', ...
          'SpeciesReference_create(sbmlLevel, sbmlVersion)', ...
          'first argument must be a valid SBML level i.e. either 1 or 2'));
    elseif ((~isIntegralNumber(varargin{2})) || (varargin{2} < 1) || (varargin{2} > 4))
        error(sprintf('%s\n%s', ...
          'SpeciesReference_create(sbmlLevel, sbmlVersion)', ...
          'second argument must be a valid SBML version i.e. either 1, 2, 3 or 4'));
    end;
    sbmlLevel = varargin{1};
    if (sbmlLevel == 1 && varargin{2} > 2)
        error(sprintf('Level - version mismatch\nAllowed combinations are L1V1 L1V2 L2V1 L2V2 L2V3 or L2V4'));
    else
        sbmlVersion = varargin{2};
    end;
    
elseif (nargin == 1)
    if ((~isIntegralNumber(varargin{1})) || (varargin{1} < 1) || (varargin{1} > 2))
        error(sprintf('%s\n%s', 'SpeciesReference_create(sbmlLevel)', ...
          'argument must be a valid SBML level i.e. either 1 or 2'));
    end;
    sbmlLevel = varargin{1};
    
end;

if (sbmlLevel == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'species', ...
      'stoichiometry', 'denominator' };
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', int32(1), int32(1)};
else
  if (sbmlVersion == 1)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'species', ...
      'stoichiometry', 'denominator', 'stoichiometryMath' };
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', '', 1, int32(1), ''};
  elseif (sbmlVersion == 2)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'species', 'id', ...
      'name', 'sboTerm', 'stoichiometry', 'stoichiometryMath'};
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', '', '', '', int32(-1), 1, ''};
  elseif (sbmlVersion > 2)
    SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation', 'sboTerm', ...
      'species', 'id', 'name', 'stoichiometry', 'stoichiometryMath'};
    Values = {'SBML_SPECIES_REFERENCE', '', '', '', int32(-1), '', '', '', 1, ''};
        
    stoichiometryMath = struct('typecode', {}, 'metaid', {}, 'notes', {}, ...
          'annotation', {}, 'sboTerm', {}, 'math', {});
  end;
end;

SpeciesReference = cell2struct(Values, SBMLfieldnames, 2);

if (sbmlLevel == 2 && sbmlVersion > 2)
  SpeciesReference = setfield(SpeciesReference, 'stoichiometryMath', ...
    stoichiometryMath);
end;

%check created structure is appropriate
if (~isSBML_SpeciesReference(SpeciesReference, sbmlLevel, sbmlVersion))
    SpeciesReference = [];
    warning('Failed to create speciesreference');
end;
