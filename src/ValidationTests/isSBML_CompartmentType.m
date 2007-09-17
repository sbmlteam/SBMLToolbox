function y = isSBML_CompartmentType(varargin)
% isSBML_CompartmentType(SBMLStructure, Level, Version(optional)) 
% checks that SBMLStructure represents a CompartmentType
% within an sbml model of specified level
% 
% if SBMLStructure represents a CompartmentType within an SBML model
% it has the appropriate fields (ONLY IN LEVEL 2 VERSION 2)
% eg    Typecode (2)
%       Notes (2)
%       Annotations (2)
%       Name (2)
%       Id (2)
%
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields and the typecode is "SBML_COMPARTMENT_TYPE"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the above fields
% or the typecode is not "SBML_COMPARTMENT_TYPE"

% /**
%  * \file    isSBML_CompartmentType.m
%  * \brief   check structure is CompartmentType
%  * \author  Sarah Keating
%  *
%  * $Id$
%  * $Source$
%  */
% /* Copyright 2002 California Institute of Technology and Japan Science and
%  * Technology Corporation.
%  *
%  * This library is free software; you can redistribute it and/or modify it
%  * under the terms of the GNU Lesser General Public License as published by
%  * the Free Software Foundation.  A copy of the license agreement is
%  * provided in the file named "LICENSE.txt" included with this software
%  * distribution.  It is also available online at
%  * http://sbml.org/software/libsbml/license.html
%  *
%  * You should have received a copy of the GNU Lesser General Public License
%  * along with this library; if not, write to the Free Software Foundation,
%  * Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%  */

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
    y = 0;
    return;
else
    if (Version == 1)
        y = 0;
        return;
    elseif (Version == 2)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'name', 'id'};
        nNumberFields = 5;
    elseif (Version == 3)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'sboTerm', 'name', 'id'};
        nNumberFields = 6;
    end;
end;
    
 typecode = 'SBML_COMPARTMENT_TYPE';

bSBML = 0;

% check that argument is a structure
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
if (bSBML == 1)
    type = SBMLStructure.typecode;
    k = strcmp(type, typecode);
    if (k ~= 1)
        bSBML = 0;
    end;
end;
 
y = bSBML;