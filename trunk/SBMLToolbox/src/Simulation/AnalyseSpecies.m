function Species = AnalyseSpecies(SBMLModel)
% AnalyseSpecies takes a matlab sbml model structure and outputs a
% structure detailing the species and how they are manipulated within the
% model
% 
% the structure fields are
%     Name
%     constant
%     boundaryCondition
%     initialValue
%     ChangedByReaction
%     KineticLaw
%     ChangedByRateRule
%     RateRule
%     ChangedByAssignmentRule
%     AssignmentRule
%     InAlgebraicRule
%     AlgebraicRule
%     ConvertedToAssignRule
%     ConvertedRule

%
%  Filename    : AnalyseSpecies.m
%  Description : takes a SBMLModel and outputs a structure
%                   defining the species
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

[name, KineticLaw] = GetRateLawsFromReactions(SBMLModel);
[n, RateRule] = GetRateLawsFromRules(SBMLModel);
[n, AssignRule] = GetSpeciesAssignmentRules(SBMLModel);
[n, AlgRules] = GetSpeciesAlgebraicRules(SBMLModel);
[n, Values] = GetSpecies(SBMLModel);

% create the output structure
for i = 1:length(SBMLModel.species)
    Species(i).Name = name(i);
    
    bc = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        const = SBMLModel.species(i).constant;
    else
        const = 0;
    end;

    
    Species(i).constant = const;
    Species(i).boundaryCondition = bc;

    Species(i).initialValue = Values(i);
    
    
    if (strcmp(KineticLaw(i), '0'))
        Species(i).ChangedByReaction = 0;
        Species(i).KineticLaw = '';
    else
        Species(i).ChangedByReaction = 1;
        Species(i).KineticLaw = KineticLaw(i);
    end;

    if (strcmp(RateRule(i), '0'))
        Species(i).ChangedByRateRule = 0;
        Species(i).RateRule = '';
    else
        Species(i).ChangedByRateRule = 1;
        Species(i).RateRule = RateRule(i);
    end;

    if (strcmp(AssignRule(i), '0'))
        Species(i).ChangedByAssignmentRule = 0;
        Species(i).AssignmentRule = '';
    else
        Species(i).ChangedByAssignmentRule = 1;
        Species(i).AssignmentRule = AssignRule(i);
    end;

    if (strcmp(AlgRules(i), '0'))
        Species(i).InAlgebraicRule = 0;
        Species(i).AlgebraicRule = '';
    else
        Species(i).InAlgebraicRule = 1;
        Species(i).AlgebraicRule = AlgRules(i);
    end;

    if ((Species(i).constant == 0) && (Species(i).ChangedByReaction == 0) && (Species(i).ChangedByRateRule == 0) && (Species(i).ChangedByAssignmentRule == 0))
        if (Species(i).InAlgebraicRule == 1)
            Species(i).ConvertedToAssignRule = 1;
            Rule = Species(i).AlgebraicRule{1};
            Species(i).ConvertedRule = Convert(name(i), char(Rule));
        end;
    else
            Species(i).ConvertedToAssignRule = 0;
            Species(i).ConvertedRule = '';
        
   end;

end;

function y = Convert(name, formula)

y = regexprep(formula, name, '0');

Plus = strfind(y, '+');
Minus = strfind(y, '-');

if (~isempty(Plus))
    y = regexprep(y, '+', '-');
end;

for i = 1:length(Minus)
    y(Minus(i)) = '+';
end;

if (y(1) ~= '+')
    y = strcat('-', y);
end;