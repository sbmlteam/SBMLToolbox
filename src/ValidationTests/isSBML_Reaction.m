function y = isSBML_Reaction(SBMLStructure, Level)
% isSBML_Reaction(SBMLStructure) checks that SBMLStructure represents a reaction 
% within an sbml model of the specified level
% 
% if SBMLStructure represents a reaction within an SBML model
% it has the appropriate fields 
% eg    Typecode
%       Notes
%       Annotations
%       Name
%       Id (2)
%       ListReactants
%       ListProducts
%       ListModifiers (2)
%       KineticLaw
%       Reversible
%       Fast
%       isSetFast (2)
%
% NOTE number in brackets indicates field is appropriate for that level of
% sbml only
%
% Returns 1 if SBMLStructure is a structure containing each of the above
% fields and the typecode is "SBML_REACTION"
% 
% Returns 0 if SBMLStructure is not a structure 
% or does not contain one of the above fields
% or the typecode is not "SBML_REACTION"

%
%  Filename    : isSBML_Reaction.m
%  Description : validates whether a MATLAB structure 
%				 respresents a SBML Reaction
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
if (Level == 1)
    SBMLfieldnames = {'typecode', 'notes', 'annotation','name', 'reactant', 'product', 'kineticLaw', 'reversible', 'fast'};
    nNumberFields = 9;
else
    SBMLfieldnames = {'typecode', 'notes', 'annotation','name', 'id', 'reactant', 'product', 'modifier', 'kineticLaw', 'reversible', 'fast', 'IsSetFast'};
    nNumberFields = 12;
end;
    
typecode = 'SBML_REACTION';

bSBML = 0;

% check that Model is a structure
bSBML = isstruct(SBMLStructure);

% check it contains each of the fields listed
index = 1;
while (bSBML == 1 && index < nNumberFields)
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
    
% check that any nested structures are appropriate
if(bSBML == 1)
    index = 1;
    [x, nNumberReactants] = size(SBMLStructure.reactant);
    while (bSBML == 1 && index <= nNumberReactants)
        bSBML = isSBML_SpeciesReference(SBMLStructure.reactant(index), Level);
        index = index + 1;
    end;

    index = 1;
    [x, nNumberProducts] = size(SBMLStructure.product);
    while (bSBML == 1 && index <= nNumberProducts)
        bSBML = isSBML_SpeciesReference(SBMLStructure.product(index), Level);
        index = index + 1;
    end;

    if (Level == 2)
        index = 1;
        [x, nNumberModifiers] = size(SBMLStructure.modifier);
        while (bSBML == 1 && index <= nNumberModifiers)
            bSBML = isSBML_ModifierSpeciesReference(SBMLStructure.modifier(index), Level);
            index = index + 1;
        end;
    end;

    % if a kinetic law is present check that it is valid
    if (bSBML == 1 && ~isempty(SBMLStructure.kineticLaw))
        bSBML = isSBML_KineticLaw(SBMLStructure.kineticLaw, Level);
    end;
end;
y = bSBML;