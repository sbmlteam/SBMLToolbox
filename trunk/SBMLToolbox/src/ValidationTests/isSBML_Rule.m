function y = isSBML_Rule(varargin)
% isSBML_Rule(SBMLStructure, Level, Version(optional)) 
% checks that SBMLStructure represents a rule 
% within an sbml model of the specified level
% 
% if SBMLStructure represents a rule within an SBML model
% it has the appropriate fields 
% eg    Typecode
%       Notes
%       Annotations
%       Type (1)
%       Formula
%       Variable
%       Species
%       Compartment
%       ParameterName
%       ParameterUnits
%
% NOTE number in brackets indicates field is appropriate for that level of
% sbml only
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields and the typecode is one of
%   "SBML_ALGEBRAIC_RULE", "SBML_SPECIES_CONCENTRATION_RULE",
%   "SBML_COMPARTMENT_VOLUME_RULE", "SBML_PARAMETER_RULE", 
%   "SBML_ASSIGNMENT_RULE", "SBML_RATE_RULE"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the above fields
% or the typecode is not one of 
%   "SBML_ALGEBRAIC_RULE", "SBML_SPECIES_CONCENTRATION_RULE",
%   "SBML_COMPARTMENT_VOLUME_RULE", "SBML_PARAMETER_RULE", 
%   "SBML_ASSIGNMENT_RULE", "SBML_RATE_RULE"

%
%  Filename    : isSBML_Rule.m
%  Description : validates whether a MATLAB structure 
%				 respresents a SBML Rule
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-09-15
%  Revision    : $Id$
%  Source      : $Source$
%
%  Copyright 2003 California Institute of Technology, the Japan Science
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
%      Science and Technology Research Centre
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):
%
%input arguments
if (nargin < 2 || nargin > 3)
    error('wrong number of input arguments');
end;

SBMLStructure = varargin{1};
Level = varargin{2};

if (nargin == 3)
    Version = varargin{3};
else
    Version = 1;
end;

if (Level == 1) 
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'type', 'formula', ...
      'variable', 'species', 'compartment', 'name', 'units'};
    nNumberFields = 10;
else
    if (Version == 1)
        SBMLfieldnames = {'typecode', 'notes', 'annotation','formula', ...
          'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 9;
    elseif (Version == 2)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 10;
    elseif (Version == 3)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'sboTerm', ...
          'formula', 'variable', 'species', 'compartment', 'name', 'units'};
        nNumberFields = 10;
    end;
end;
typecodel1 = {'SBML_ALGEBRAIC_RULE', 'SBML_SPECIES_CONCENTRATION_RULE', ...
  'SBML_COMPARTMENT_VOLUME_RULE', 'SBML_PARAMETER_RULE'};
nNumberTypecodesl1 = 4;

typecodel2 = {'SBML_ALGEBRAIC_RULE', 'SBML_ASSIGNMENT_RULE', 'SBML_RATE_RULE'};
nNumberTypecodesl2 = 3;

bSBML = 0;

% check that Rule is a structure
bSBML = isstruct(SBMLStructure);

% check it contains each of the fields listed
index = 1;
while (bSBML == 1 && index <= nNumberFields)
    bSBML = isfield(SBMLStructure, SBMLfieldnames(index));
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
index = 1;
nMatch = 0;
if (bSBML == 1)
type = SBMLStructure.typecode;
  if (Level == 1)
    while (index <= nNumberTypecodesl1)
        k = strcmp(type, typecodel1(index));
        if (k == 1)
            nMatch = nMatch + 1;
        end;
        index = index + 1;
    end;
    if (nMatch == 0)
        bSBML = 0;
    end;
  else
    while (index <= nNumberTypecodesl2)
        k = strcmp(type, typecodel2(index));
        if (k == 1)
            nMatch = nMatch + 1;
        end;
        index = index + 1;
    end;
    if (nMatch == 0)
        bSBML = 0;
    end;
  end;
end;
    

y = bSBML;