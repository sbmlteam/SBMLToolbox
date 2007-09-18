function y = IsSpeciesInReaction(SBMLSpecies, SBMLReaction)
% IsSpeciesInReaction takes an SBML species and an SBML reaction
% and returns
%       the number of times the species occurs within the reaction


%  Filename    : IsSpeciesInReaction.m
%  Description : IsSpeciesInReaction(SBMLSpecies, SBMLReaction)takes a SBML species and  reaction
%               and determines where the species takes part in the reaction
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-02-02
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
%

% check that input is valid
SBMLLevel = 1;
SBMLVersion = 1;

if (~isSBML_Species(SBMLSpecies, 1))
    SBMLLevel = 2;
    if(~isSBML_Species(SBMLSpecies, 2))
        SBMLVersion = 2;
        if(~isSBML_Species(SBMLSpecies, 2, 2))
            SBMLVersion = 3;
            if(~isSBML_Species(SBMLSpecies, 2, 3))
                error('IsSpeciesInReaction(SBMLSpecies, SBMLReaction)\n%s', 'first input must be an SBML Species structure');
            end;
        end;
    end;
end;

if(~isSBML_Reaction(SBMLReaction, SBMLLevel, SBMLVersion))
    error('IsSpeciesInReaction(SBMLSpecies, SBMLReaction)\n%s', 'second input must be an SBML Reaction structure');
end;

%--------------------------------------------------------------------------
% determine the name of the species
% this will match to the speciesreference within the reaction

if (SBMLLevel == 1)
    name = SBMLSpecies.name;
else
    if (isempty(SBMLSpecies.id))
        name = SBMLSpecies.name;
    else
        name = SBMLSpecies.id;
    end;
end;

%--------------------------------------------------------------------------
%determine number of each type of species included within this reaction

NumProducts = length(SBMLReaction.product);
NumReactants = length(SBMLReaction.reactant);
if (SBMLLevel == 2)
    NumModifiers = length(SBMLReaction.modifier);
else
    NumModifiers = 0;
end;

%-------------------------------------------------------------------------
% find species in this reaction
 y = 0;
for c = 1:NumProducts
    if (strcmp(name, SBMLReaction.product(c).species))
        y = y + 1;
    end;
end;

for c = 1:NumReactants
    if (strcmp(name, SBMLReaction.reactant(c).species))
        y = y + 1;
    end;
end;

for c = 1:NumModifiers
    if (strcmp(name, SBMLReaction.modifier(c).species))
        y = y + 1;
    end;
end;


