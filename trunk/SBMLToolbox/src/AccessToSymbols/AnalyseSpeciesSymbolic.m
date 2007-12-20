function Species = AnalyseSpeciesSymbolic(SBMLModel)
% AnalyseSpeciesSymbolic takes a matlab sbml model structure 
% and returns
%           structure detailing the species and 
%               how they are manipulated within the model
% 
% the structure fields are
%     Name
%     SpeciesType (L2V2)
%     constant
%     boundaryCondition
%     initialValue
%     hasInitialAssignment (L2V2)
%     initialAssisgnment (L2V2)
%     isConcentration
%     compartment
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
%  Filename    : AnalyseSpeciesSymbolic.m
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
%------------------------------------------------------------
if (~isSBML_Model(SBMLModel))
    error('AnalyseSpeciesSymbolic(SBMLModel)\n%s', 'argument must be an SBMLModel structure');
end;

% look for functions and warn user that these are not dealt with yet
% if (SBMLModel.SBML_level == 2)
%     Funcs = length(SBMLModel.functionDefinition);
% else
%     Funcs = 0;
% end;
% 
% if (Funcs ~= 0)
%     error('Note this procedure does not yet deal with functions');
% end;

[name, KineticLaw] = GetSymbolicRateLawsFromReactions(SBMLModel);
[n, RateRule] = GetSymbolicRateLawsFromRules(SBMLModel);
[n, AssignRule] = GetSymbolicSpeciesAssignmentRules(SBMLModel);
[n, AlgRules] = GetSymbolicSpeciesAlgebraicRules(SBMLModel);
[n, Values] = GetSpecies(SBMLModel);
if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
  [n, InitialAss] = GetSymbolicSpeciesInitialAssignments(SBMLModel); 
end;

% create the output structure
for i = 1:length(SBMLModel.species)
    Species(i).Name = name(i);

    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version  > 1)
      Species(i).speciesType = SBMLModel.species(i).speciesType;
    end;
    
    bc = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        const = SBMLModel.species(i).constant;
    else
        const = 0;
    end;

    
    Species(i).constant = const;
    Species(i).boundaryCondition = bc;

    if (isnan(Values(i)))
      Species(i).initialValue = -1;
    else
      Species(i).initialValue = Values(i);
    end;
    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
      if (InitialAss{i} == sym('0'))
        Species(i).hasInitialAssignment = 0;
        Species(i).initialAssignment = '';
      elseif (isempty(InitialAss{i}))
        Species(i).hasInitialAssignment = 0;
        Species(i).initialAssignment = '';
      else
        Species(i).hasInitialAssignment = 1;
        Species(i).initialAssignment = InitialAss{i};
      end;
        
    end;
    
    if (SBMLModel.SBML_level == 2 && SBMLModel.species(i).isSetInitialConcentration == 1)
        Species(i).isConcentration = 1;
    else
        Species(i).isConcentration = 0;
    end;
    
    Species(i).compartment = sym(SBMLModel.species(i).compartment);
    
    if (KineticLaw(i) == 0)
        Species(i).ChangedByReaction = 0;
        Species(i).KineticLaw = '';
    else
        Species(i).ChangedByReaction = 1;
        Species(i).KineticLaw = KineticLaw(i);
    end;

    if (RateRule(i) == 0)
        Species(i).ChangedByRateRule = 0;
        Species(i).RateRule = '';
    else
        Species(i).ChangedByRateRule = 1;
        Species(i).RateRule = RateRule(i);
    end;

    if (isempty(AssignRule{i}))
        Species(i).ChangedByAssignmentRule = 0;
        Species(i).AssignmentRule = '';
    else
        Species(i).ChangedByAssignmentRule = 1;
        Species(i).AssignmentRule = AssignRule{i};
    end;

    if (isempty(AlgRules{i}))
        Species(i).InAlgebraicRule = 0;
        Species(i).AlgebraicRule = '';
    else
        Species(i).InAlgebraicRule = 1;
        Species(i).AlgebraicRule = AlgRules{i};
    end;

    if ((Species(i).constant == 0) && (Species(i).ChangedByReaction == 0) && (Species(i).ChangedByRateRule == 0) && (Species(i).ChangedByAssignmentRule == 0))
        if (Species(i).InAlgebraicRule == 1)
            Species(i).ConvertedToAssignRule = 1;
            Rule = Species(i).AlgebraicRule;
            
            % need to look at whether rule contains a user definined
            % function
            FunctionIds = Model_getFunctionIds(SBMLModel);
            for f = 1:length(FunctionIds)
                if (strfind(char(Rule), FunctionIds{f}))
                    Rule = SubstituteFunction(char(Rule), SBMLModel.functionDefinition(f));
                end;
                
            end;
            
            SubsRule = SubsAssignmentRules(SBMLModel, Rule);
            Species(i).ConvertedRule = solve(SubsRule, name(i));
        else
            Species(i).ConvertedToAssignRule = 0;
            Species(i).ConvertedRule = '';
        end;
    elseif ((Species(i).initialValue == -1) && (Species(i).InAlgebraicRule == 1))
        error ('The model is over parameterised and the simulation cannot make decisions regarding rules');
    
    else
        Species(i).ConvertedToAssignRule = 0;
        Species(i).ConvertedRule = '';

    end;

end;


function form = SubsAssignmentRules(SBMLModel, rule)

[species, AssignRule] = GetSymbolicSpeciesAssignmentRules(SBMLModel);
form = rule;
for i = 1:length(species)
    if (~isempty(AssignRule{i}))
        form = subs(form, species(i), AssignRule{i});
    end;
end;
