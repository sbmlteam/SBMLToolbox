function y = IsSpeciesInAlgebraicRule(SBMLSpecies, SBMLRules)
% IsSpeciesInAlgebraicRule takes an SBMLSpecies structure and an array of SBMLRule structures
% and returns
%             0 if the species is not in an algebraic rule
%             [n1, n2] if the species occurs as within a rule
%     where n1, n2 refers to the index of the matched rule in the array

%------------------------------------------------------------------------
%
%  Filename    : IsSpeciesInAlgebraicRule.m
%  Description : takes a SBMLSpecies and set of rules and returns the
%  number of the assignment rules for the species
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-12-06
%  Revision    : $Id$
%  Source      : $Source $
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
 
y = 0;

%-------------------------------------------------------------------
% check input arguments are as expected

SBMLLevel = 1;
if (~isSBML_Species(SBMLSpecies, SBMLLevel))
    SBMLLevel = 2;
    if (~isSBML_Species(SBMLSpecies, SBMLLevel))
        error('IsSpeciesInAlgebraicRule(SBMLSpecies, SBMLRules)\n%s', 'first argument must be an SBMLSpecies structure');
    end;
end;


NumRules = length(SBMLRules);

if (NumRules < 1)
    error('IsSpeciesInAlgebraicRule(SBMLSpecies, SBMLRules)\n%s', 'SBMLRule structure is empty');
else
    for i = 1:NumRules
        if (~isSBML_Rule(SBMLRules(i), SBMLLevel))
            error('IsSpeciesAssignedByRule(SBMLSpecies, SBMLRules)\n%s', 'second argument must be an array of SBMLRule structures');
        end;
    end;
end;

%--------------------------------------------------------------------------

% loop through each rule and check whether the species occurs
%determine the name or id of the species
if (SBMLLevel == 1)
    name = SBMLSpecies.name;
else
    if (isempty(SBMLSpecies.id))
        name = SBMLSpecies.name;
    else
        name = SBMLSpecies.id;
    end;
end;

y = [];
for i = 1:NumRules
    index = strfind(SBMLRules(i).formula, name);
    if (~isempty(index))
        y = [y;i];
    end;
end;

