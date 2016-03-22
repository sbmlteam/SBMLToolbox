function [valid, message] = isSBML_Rule(varargin)
% [valid, message] = isSBML_Rule(SBMLRule, level, version(optional))
%
% Takes
%
% 1. SBMLRule, an SBML Rule structure
% 2. level, an integer representing an SBML level
% 3. version (optional), an integer representing an SBML version
%
% Returns
%
% 1. valid = 
%   - 1, if the structure represents
%        a MATLAB_SBML Rule structure of the appropriate
%        level and version
%   - 0, otherwise
% 2. a message explaining any failure
%
% *NOTE:* the optional version defaults to a value of 1
%
% *NOTE:* The fields present in a MATLAB_SBML Rule structure of the appropriate
% level and version can be found using getRuleFieldnames(level, version)

%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2016 jointly by the following organizations: 
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




%check the input arguments are appropriate

if (nargin < 2 || nargin > 3)
	error('wrong number of input arguments');
end;

SBMLStructure = varargin{1};

if (length(SBMLStructure) > 1)
  valid = 0;
  message = 'cannot deal with arrays of structures';
  return;
end;

level = varargin{2};

if (nargin == 3)
	version = varargin{3};
else
	version = 1;
end;

isValidLevelVersionCombination(level, version);

message = '';

if ~isempty(SBMLStructure)
  if isfield(SBMLStructure, 'typecode')
    typecode = SBMLStructure.typecode;
  else
    valid = 0;
    message = 'missing typecode';
    return;
  end;
else
  typecode = 'SBML_ASSIGNMENT_RULE';
end;

switch (typecode)
  case 'SBML_ALGEBRAIC_RULE'
    [valid, message] = isSBML_AlgebraicRule(SBMLStructure, level, version);
  case 'SBML_ASSIGNMENT_RULE'
    [valid, message] = isSBML_AssignmentRule(SBMLStructure, level, version);
  case 'SBML_COMPARTMENT_VOLUME_RULE'
    [valid, message] = isSBML_CompartmentVolumeRule(SBMLStructure, level, version);
  case 'SBML_PARAMETER_RULE'
    [valid, message] = isSBML_ParameterRule(SBMLStructure, level, version);
  case 'SBML_RATE_RULE'
    [valid, message] = isSBML_RateRule(SBMLStructure, level, version);
  case 'SBML_SPECIES_CONCENTRATION_RULE'
    [valid, message] = isSBML_SpeciesConcentrationRule(SBMLStructure, level, version);
  case 'SBML_RULE'
    [valid, message] = checkRule(SBMLStructure, level, version);
  otherwise
    valid = 0;
    message = 'Incorrect rule typecode';
 end;
 

function [valid, message] = checkRule(SBMLStructure, level, version)


message = '';

% check that argument is a structure
valid = isstruct(SBMLStructure);

% check the typecode
typecode = 'SBML_RULE';
if (valid == 1 && ~isempty(SBMLStructure))
  if (strcmp(typecode, SBMLStructure.typecode) ~= 1)
    valid = 0;
    message = 'typecode mismatch';
  end;
end;

% if the level and version fields exist they must match
if (valid == 1 && isfield(SBMLStructure, 'level') && ~isempty(SBMLStructure))
	if ~isequal(level, SBMLStructure.level)
		valid = 0;
		message = 'level mismatch';
	end;
end;
if (valid == 1 && isfield(SBMLStructure, 'version') && ~isempty(SBMLStructure))
	if ~isequal(version, SBMLStructure.version)
		valid = 0;
		message = 'version mismatch';
	end;
end;

% check that structure contains all the necessary fields
[SBMLfieldnames, numFields] = getAlgebraicRuleFieldnames(level, version);

if (numFields ==0)
	valid = 0;
	message = 'invalid level/version';
end;

index = 1;
while (valid == 1 && index <= numFields)
	valid = isfield(SBMLStructure, char(SBMLfieldnames(index)));
	if (valid == 0);
		message = sprintf('%s field missing', char(SBMLfieldnames(index)));
	end;
	index = index + 1;
end;

% report failure
if (valid == 0)
	message = sprintf('Invalid Rule\n%s\n', message);
end;

