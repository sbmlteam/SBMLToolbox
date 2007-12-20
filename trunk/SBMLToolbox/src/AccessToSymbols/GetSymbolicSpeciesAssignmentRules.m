function [Species, AssignmentRules] = GetSymbolicSpeciesAssignmentRules(SBMLModel)
% GetSymbolicSpeciesAssignmentRules takes an SBMLModel 
% and returns
%             1) an array of species symbols
%             2) an array of the symbolic representation of the
%             assignment for each species assigned by rules

%--------------------------------------------------------------------------
%
%  Filename    : GetSymbolicSpeciesAssignmentRules.m
%  Description : takes a SBMLModel and returns assignments
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


% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetSymbolicSpeciesAssignmentRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
            
% get information from the model
Species = GetSpeciesSymbols(SBMLModel);
NumberSpecies = length(SBMLModel.species);
AssignRules = Model_getListOfAssignmentRules(SBMLModel);
NumAssignRules = Model_getNumAssignmentRules(SBMLModel);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
    symOut = sym(output);
 
    % if species is constant in level 2
    % concentration cannot be changed by a rule
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;
    
    if (constant == 1)
%         symOut = sym('0');
    else

        if (NumAssignRules > 0)
        %determine which rules it occurs within
        RuleNo = Species_isAssignedByRule(SBMLModel.species(i), AssignRules);
        if (RuleNo > 0)
           Formula = AssignRules(RuleNo).formula;
           if (SBMLModel.SBML_level > 1)
            for fd = 1:Model_getNumFunctionDefinitions(SBMLModel)
                newFormula = SubstituteFunction(Formula, Model_getFunctionDefinition(SBMLModel, fd));
                if (~isempty(newFormula))
                  Formula = newFormula;
                end;
            end;
           end;
           symOut = charFormula2sym(Formula);

        end;
        end;

    end; % if constant


    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
%     if (isempty(symOut))
%         AssignmentRules{i} = sym('0');
%     else
        AssignmentRules{i} = symOut;
%     end;
    
end; % for NumSpecies
