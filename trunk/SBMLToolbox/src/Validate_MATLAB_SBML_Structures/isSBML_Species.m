function [y, message] = isSBML_Species(varargin)
% isSBML_Species(SBMLStructure, Level, Version(optional)) 
% checks that SBMLStructure represents a species 
% within an sbml model of specified level
% 
% if SBMLStructure represents a species within an SBML model
% it has the appropriate fields
% eg    Typecode
%       Metaid (L2V1)
%       Notes
%       Annotations
%       SBOTerm (L2V3)
%       Name
%       Id (L2V1)
%       SpeciesType (L2V2)
%       Compartment
%       InitialAmount
%       InitialConcentration (L2V1)
%       Units (L1V1 - L1V2)
%       SubstanceUnits (L2V1)
%       SpatialSizeUnits (L2V1 - L2V2)
%       HasOnlySubstanceUnits (L2V1)
%       BoundaryCondition
%       Charge
%       Constant (L2V1)
%       isSetInitialAmount
%       isSetInitialConcentration (L2V1)
%       isSetCharge
%
% NOTE: content of brackets indicates the level and version of sbml from which the given field
% is appropriate.
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields (appropriate with the given level and version) 
% and the typecode is "SBML_SPECIES"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the appropriate fields
% or the typecode is not "SBML_SPECIES"
%
% Returns message indicating the structure that is invalid.

%  Filename    :   isSBML_Species.m
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

if (Level == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation','name', 'compartment', 'initialAmount', ...
        'units', 'boundaryCondition', 'charge', 'isSetInitialAmount', 'isSetCharge'};
    nNumberFields = 11;
else
    if (Version == 1)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','name', 'id', 'compartment', 'initialAmount', ...
            'initialConcentration', 'substanceUnits', 'spatialSizeUnits',  'hasOnlySubstanceUnits', ...
            'boundaryCondition', 'charge', 'constant', 'isSetInitialAmount', 'isSetInitialConcentration', ...
            'isSetCharge'};
        nNumberFields = 18;
    elseif (Version == 2)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','name', 'id', 'speciesType', 'compartment', ...
            'initialAmount', 'initialConcentration', 'substanceUnits', 'spatialSizeUnits',  ...
            'hasOnlySubstanceUnits', 'boundaryCondition', 'charge', 'constant', 'isSetInitialAmount', ...
            'isSetInitialConcentration','isSetCharge'};
        nNumberFields = 19;
    elseif (Version == 3)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','sboTerm', 'name', 'id', 'speciesType', 'compartment', ...
            'initialAmount', 'initialConcentration', 'substanceUnits',  ...
            'hasOnlySubstanceUnits', 'boundaryCondition', 'charge', 'constant', 'isSetInitialAmount', ...
            'isSetInitialConcentration','isSetCharge'};
        nNumberFields = 19;
    elseif (Version == 4)
        SBMLfieldnames = {'typecode', 'metaid', 'notes', 'annotation','sboTerm', 'name', 'id', 'speciesType', 'compartment', ...
            'initialAmount', 'initialConcentration', 'substanceUnits',  ...
            'hasOnlySubstanceUnits', 'boundaryCondition', 'charge', 'constant', 'isSetInitialAmount', ...
            'isSetInitialConcentration','isSetCharge'};
        nNumberFields = 19;
    end;
end;
typecode = 'SBML_SPECIES';

bSBML = 0;

% check that argument is a structure
bSBML = isstruct(SBMLStructure);

% check it contains each of the fields listed
index = 1;
while (bSBML == 1 && index <= nNumberFields)
    bSBML = isfield(SBMLStructure, char(SBMLfieldnames(index)));
    index = index + 1;
end;

% check that it contains only the fields listed
if (bSBML == 1)
    names = fieldnames(SBMLStructure);
    [m,n] = size(names);
    if (m ~= nNumberFields)
        bSBML = 0;
    end;
end;

% check that the typecode is correct
if (bSBML == 1)
    type = SBMLStructure.typecode;
    k = strcmp(type, typecode);
    if (k ~= 1)
        bSBML = 0;
    end;
end;
    
if (bSBML == 0)
  message = 'Invalid Species structure';
end;

y = bSBML;
