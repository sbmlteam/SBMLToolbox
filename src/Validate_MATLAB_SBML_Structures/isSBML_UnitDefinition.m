function [valid, message] = isSBML_UnitDefinition(varargin)
%
% isSBML_UnitDefinition
%    takes a MATLAB_SBML structure
%          an SBML level
%    and optionally an SBML version
%
%    returns
%      1) a flag indicating whether the structure represents
%           an MATLAB_SBML UnitDefinition structure of the appropriate
%           level and version
%      2) a message string explaining any failure
%
% NOTE: the optional version defaults to a value of 1 
%
% The fields present in MATLAB_SBML UnitDefinition structure of the appropriate
% level and version can be found using getUnitDefinitionFieldnames(level, version)

%  Filename    :   isSBML_UnitDefinition.m
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


%check the input arguments are appropriate

if (nargin < 2 || nargin > 3)
	error('wrong number of input arguments');
end;

SBMLStructure = varargin{1};

if (length(SBMLStructure) > 1)
	error('cannot deal with arrays of structures');
end;

level = varargin{2};

if (level < 1 || level > 3)
	error('current SBML levels are 1, 2 or 3');
end;

if (nargin == 3)
	version = varargin{3};
else
	version = 1;
end;

if (level == 1)
	if (version < 1 || version > 2)
		error('SBMLToolbox supports versions 1-2 of SBML Level 1');
	end;

elseif (level == 2)
	if (version < 1 || version > 4)
		error('SBMLToolbox supports versions 1-4 of SBML Level 2');
	end;

elseif (level == 3)
	if (version ~= 1)
		error('SBMLToolbox supports only version 1 of SBML Level 3');
	end;

end;

message = '';

% check that argument is a structure
valid = isstruct(SBMLStructure);

% check the typecode
typecode = 'SBML_UNIT_DEFINITION';
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
[SBMLfieldnames, numFields] = getFieldnames('SBML_UNIT_DEFINITION', level, version);

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

%check that any nested structures are appropriate

% unit
if (valid == 1)
  index = 1;
  while (valid == 1 && index <= length(SBMLStructure.unit))
    [valid, message] = isSBML_Unit(SBMLStructure.unit(index), ...
                                  level, version);
    index = index + 1;
  end;
end;


% report failure
if (valid == 0)
	message = sprintf('Invalid UnitDefinition\n%s\n', message);
end;
