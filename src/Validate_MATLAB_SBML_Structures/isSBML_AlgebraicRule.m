function [y, message] = isSBML_AlgebraicRule(varargin)
% isSBML_AlgebraicRule(SBMLStructure, Level, Version(optional)) 
% checks that SBMLStructure represents an algebraic rule 
% within an sbml model of the specified level
% 
% if SBMLStructure represents a rule within an SBML model
% it has the appropriate fields 
% eg    Typecode
%       Notes
%       Annotations
%       SBOTerm (L2V2)
%       Type (L1V1 - L1V2)
%       Formula
%       Variable
%       Species
%       Compartment
%       ParameterName
%       ParameterUnits
%
% NOTE: content of brackets indicates the level and version of sbml from which the given field
% is appropriate.
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields (appropriate with the given level and version) 
% and the typecode is  "SBML_ALGEBRAIC_RULE"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the appropriate fields
% or the typecode is not  "SBML_ALGEBRAIC_RULE"
%
% Returns message indicating the structure that is invalid.

%  Filename    :   isSBML_AlgebraicRule.m
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

if (nargin < 2 || nargin > 3)
    error('wrong number of input arguments');
end;

message = '';

SBMLStructure = varargin{1};
Level = varargin{2};

if (nargin == 3)
    Version = varargin{3};
else
    Version = 1;
end;

typecode = 'SBML_ALGEBRAIC_RULE';

% if the level and version field exist - they must match
if (length(SBMLStructure) == 1 && isfield(SBMLStructure, 'level'))
  if ~isequal(Level, SBMLStructure.level)
    error (sprintf('%s %s', typecode, 'SBML level mismatch detected'));
  end;
  if (isfield(SBMLStructure, 'version'))
    if ~isequal(Version, SBMLStructure.version)
      error (sprintf('%s %s', typecode, 'SBML version mismatch detected'));
    end;
  end;
end;


bSBML = isSBML_Rule(SBMLStructure, Level, Version);


% check that the typecode is correct
if (bSBML == 1 && length(SBMLStructure) == 1)
    type = SBMLStructure.typecode;
    k = strcmp(type, typecode);
    if (k ~= 1)
        bSBML = 0;
    end;
end;
    
if (bSBML == 0)
  message = 'Invalid AlgebraicRule structure';
end;

y = bSBML;
