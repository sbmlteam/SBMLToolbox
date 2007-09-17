function y = isSBML_Model(SBMLStructure)
% isSBML_Model(SBMLStructure) checks that SBMLStructure represents an sbml model
% 
% if SBMLStructure represents an SBML model
% it has the appropriate fields 
% eg    Typecode
%       Notes
%       Annotations
%       Level
%       Version
%       Name
%       Id (2)
%       ListFunctionDefinition (2)
%       ListUnitDefinition
%       ListCompartment
%       ListSpecies
%       ListParameter
%       ListRule
%       ListReaction
%       ListEvent (2)
%
% NOTE number in brackets indicates field is appropriate for that level of
% sbml only
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields and the typecode is "SBML_MODEL"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the above fields
% or the typecode is not "SBML_MODEL"

%
%  Filename    : isSBML_Model.m
%  Description : validates whether a MATLAB structure 
%				 respresents a SBML Model
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
% check that there is a level
y = isfield(SBMLStructure, 'SBML_level');
if (y == 0)
    return;
end;

% get level
Level = SBMLStructure.SBML_level;
if (Level < 1 || Level > 2)
    y = 0;
    return;
end;

% get version
Version = SBMLStructure.SBML_version;
if (Version < 1 || Version > 3)
    y = 0;
    return;
end;


if (Level == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'unitDefinition',...
        'compartment', 'species', 'parameter', 'rule', 'reaction'};
    nNumberFields = 12;
else
    if (Version == 1)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', ...
            'functionDefinition', 'unitDefinition', 'compartment', 'species', 'parameter', 'rule', 'reaction',...
            'event'};
        nNumberFields = 15;
    elseif (Version == 2)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', ...
            'sboTerm', 'functionDefinition', 'unitDefinition', 'compartmentType', 'speciesType', 'compartment', ...
            'species', 'parameter', 'initialAssignment', 'rule', 'constraint', 'reaction', 'event'};
        nNumberFields = 20;
    elseif (Version == 3)
        SBMLfieldnames = {'typecode', 'notes', 'annotation', 'SBML_level', 'SBML_version', 'name', 'id', ...
            'sboTerm', 'functionDefinition', 'unitDefinition', 'compartmentType', 'speciesType', 'compartment', ...
            'species', 'parameter', 'initialAssignment', 'rule', 'constraint', 'reaction', 'event'};
        nNumberFields = 20;
    end;
end;
typecode = 'SBML_MODEL';

bSBML = 0;

% check that Model is a structure
bSBML = isstruct(SBMLStructure);

% check it contains each of the fields listed
index = 1;
while (bSBML == 1 && index <= nNumberFields)
    bSBML = isfield(SBMLStructure, SBMLfieldnames(index));
    index = index + 1;
end;

% check that it contains only the fields listed
% take out this requirement as a user may wish to 
% add their own fields
% if (bSBML == 1)
%     names = fieldnames(SBMLStructure);
%     [m,n] = size(names);
%     if (m ~= nNumberFields)
%         bSBML = 0;
%     end;
% end;
% 
% check that the typecode is correct
if (bSBML == 1)
    type = SBMLStructure.typecode;
    k = strcmp(type, typecode);
    if (k ~= 1)
        bSBML = 0;
    end;
end;
  
% check that any nested structures are appropriate
if (bSBML == 1)
    if (Level == 2)
        index = 1;
        [x, nNumber] = size(SBMLStructure.functionDefinition);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_FunctionDefinition(SBMLStructure.functionDefinition(index), Level, Version);
            index = index + 1;
        end;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.unitDefinition);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_UnitDefinition(SBMLStructure.unitDefinition(index), Level, Version);
        index = index + 1;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.compartment);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_Compartment(SBMLStructure.compartment(index), Level, Version);
        index = index + 1;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.species);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_Species(SBMLStructure.species(index), Level, Version);
        index = index + 1;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.parameter);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_Parameter(SBMLStructure.parameter(index), Level, Version);
        index = index + 1;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.rule);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_Rule(SBMLStructure.rule(index), Level, Version);
        index = index + 1;
    end;

    index = 1;
    [x, nNumber] = size(SBMLStructure.reaction);
    while (bSBML == 1 && index <= nNumber)
        bSBML = isSBML_Reaction(SBMLStructure.reaction(index), Level, Version);
        index = index + 1;
    end;

    if (Level == 2)
        index = 1;
        [x, nNumber] = size(SBMLStructure.event);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_Event(SBMLStructure.event(index), Level, Version);
            index = index + 1;
        end;
    end;
    
    if (Level == 2 && Version == 2)
        index = 1;
        [x, nNumber] = size(SBMLStructure.compartmentType);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_CompartmentType(SBMLStructure.compartmentType(index), Level, Version);
            index = index + 1;
        end;
    
        index = 1;
        [x, nNumber] = size(SBMLStructure.speciesType);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_SpeciesType(SBMLStructure.speciesType(index), Level, Version);
            index = index + 1;
        end;

        index = 1;
        [x, nNumber] = size(SBMLStructure.initialAssignment);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_InitialAssignment(SBMLStructure.initialAssignment(index), Level, Version);
            index = index + 1;
        end;
 
        index = 1;
        [x, nNumber] = size(SBMLStructure.constraint);
        while (bSBML == 1 && index <= nNumber)
            bSBML = isSBML_Constraint(SBMLStructure.constraint(index), Level, Version);
            index = index + 1;
        end;
    
    end;
    
end;
y = bSBML;