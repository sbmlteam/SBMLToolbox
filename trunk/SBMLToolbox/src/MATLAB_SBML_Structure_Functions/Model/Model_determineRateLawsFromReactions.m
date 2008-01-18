function [Species, RateLaws] = Model_determineRateLawsFromReactions(SBMLModel)
% Model_determineRateLawsFromReactions takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species

%  Filename    :   Model_determineRateLawsFromReactions.m
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



% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('Model_determineRateLawsFromReactions(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
            
% get information from the model
Species = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
NumReactions = length(SBMLModel.reaction);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';

    % if species is a boundary condition (or constant in level 2
    % no rate law is required
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;

    if (boundary == 1)
        output = '0';
    elseif (constant ==1)
        output = '0';
    else

        %determine which reactions it occurs within
        for j = 1:NumReactions

            SpeciesRole = Species_determineRoleInReaction(SBMLModel.species(i), SBMLModel.reaction(j));

            TotalOccurences = 0;
            % record numbers of occurences of species as reactant/product
            % and check that we can deal with reaction
            if (sum(SpeciesRole)>0)

                NoReactants = SpeciesRole(2);
                NoProducts =  SpeciesRole(1);
                TotalOccurences = NoReactants + NoProducts; 

                %--------------------------------------------------------------
                % check that a species does not occur twice on one side of the
                % reaction
                if (NoReactants > 1 || NoProducts > 1)
                    error('Model_determineRateLawsFromReactions(SBMLModel)\n%s', 'SPECIES OCCURS MORE THAN ONCE ON ONE SIDE OF REACTION');
                end;

                %--------------------------------------------------------------
                % check that reaction has a kinetic law formula
                if (isempty(SBMLModel.reaction(j).kineticLaw) || isempty(SBMLModel.reaction(j).kineticLaw.formula))
                    error('Model_determineRateLawsFromReactions(SBMLModel)\n%s', 'NO KINETIC LAW SUPPLIED');
                end;
                %--------------------------------------------------------------


            end;

            % species has been found in this reaction
            while (TotalOccurences > 0) %

                % add the kinetic law to the output for this species

                if(NoProducts > 0)

                    % Deal with case where parameter is defined within the reaction
                    % and thus the reaction name has been appended to the parameter
                    % name in the list in case of repeated use of same name
                    Param_Name = GetParameterFromReaction(SBMLModel.reaction(j));


                    if (~isempty(Param_Name))
                        ReviseParam_Name = GetParameterFromReactionUnique(SBMLModel.reaction(j));
                        formula = Substitute(Param_Name, ReviseParam_Name, SBMLModel.reaction(j).kineticLaw.formula);
                    else
                        formula = SBMLModel.reaction(j).kineticLaw.formula;

                    end;


                    % put in stoichiometry
                    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry;
                    else
                        stoichiometry = SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometry/double(SBMLModel.reaction(j).product(SpeciesRole(4)).denominator);
                    end;
                    if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath)))
                      if (SBMLModel.SBML_version < 3)   
                         output = sprintf('%s + (%s) * (%s)', output, SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath, formula);
                      else
                         output = sprintf('%s + (%s) * (%s)', output, SBMLModel.reaction(j).product(SpeciesRole(4)).stoichiometryMath.math, formula);
                      end;
                    else
                    % if stoichiometry = 1 no need to include it in formula
                    if (stoichiometry == 1)
                        output = sprintf('%s + (%s)', output, formula);
                    else
                        output = sprintf('%s + %u * (%s)', output, stoichiometry, formula);
                    end;

                         
                    end;
                    NoProducts = NoProducts - 1;

                elseif (NoReactants > 0)

                    % Deal with case where parameter is defined within the reaction
                    % and thus the reaction name has been appended to the parameter
                    % name in the list in case of repeated use of same name
                    Param_Name = GetParameterFromReaction(SBMLModel.reaction(j));

                    if (~isempty(Param_Name))
                        ReviseParam_Name = GetParameterFromReactionUnique(SBMLModel.reaction(j));
                        formula = Substitute(Param_Name, ReviseParam_Name, SBMLModel.reaction(j).kineticLaw.formula);
                    else
                        formula = SBMLModel.reaction(j).kineticLaw.formula;

                    end;


                    % put in stoichiometry
                    if (SBMLModel.SBML_level == 2 && SBMLModel.SBML_version > 1)
                        stoichiometry = SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry;
                    else
                        stoichiometry = SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometry/double(SBMLModel.reaction(j).reactant(SpeciesRole(5)).denominator);
                    end;
                    if ((SBMLModel.SBML_level == 2) && (~isempty(SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath)))
                      if (SBMLModel.SBML_version < 3)   
                        output = sprintf('%s - (%s) * (%s)', output, SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath, formula);
                      else
                        output = sprintf('%s - (%s) * (%s)', output, SBMLModel.reaction(j).reactant(SpeciesRole(5)).stoichiometryMath.math, formula);
                      end;
                    else
                    % if stoichiometry = 1 no need to include it in formula
                    if (stoichiometry == 1)
                        output = sprintf('%s - (%s)', output, formula);
                    else
                        output = sprintf('%s - %u * (%s)', output, stoichiometry, formula);
                    end;

                         
                    end;
                    
                    NoReactants = NoReactants - 1;
                    
                end; 
                
                
                
                TotalOccurences = TotalOccurences - 1;
                
            end; % while found > 0
            
        end; % for NumReactions
        
    end; % if boundary condition
    
    
    % finished looking for this species
    % record rate law and loop to next species
    % rate = 0 if no law found
    if (isempty(output))
        RateLaws{i} = '0';
    else
        RateLaws{i} = output;
    end;
    
end; % for NumSpecies





function y = Substitute(InitialCharArray, ReplacementParams, Formula)

Allowed = {'(',')','*','/','+','-','^', ' ', ','};
% get the number of parameters to be replced
NumberParams = length(InitialCharArray);


% want these in order of shortest to longest
% since shorter may be subsets of longer 
% ie.  'alpha'  is a subset of 'alpha1'

% determine length of each parameter
for i = 1:NumberParams
    NoCharsInParam(i) = length(InitialCharArray{i});
end;

% create an array of the index of the shortest to longest
[NoCharsInParam, Index] = sort(NoCharsInParam);

% rewrite the arrays of parameters from shortest to longest
for i = 1:NumberParams
    OrderedCharArray{i} = InitialCharArray{Index(i)};
    OrderedReplacements{i} = ReplacementParams{Index(i)};
end;

RevisedFormula = Formula;

for i = NumberParams:-1:1
    % before replacing a character need to check that it is not part of a
    % word etc 
    NumOccurences = length(findstr(OrderedCharArray{i}, RevisedFormula));
    for j = 1:NumOccurences
        k = findstr(OrderedCharArray{i}, RevisedFormula);
        if (k(j) == 1)
            before = ' ';
        else
            before = RevisedFormula(k(j)-1);
        end;
        if ((k(j)+length(OrderedCharArray{i})) < length(RevisedFormula))
            after = RevisedFormula(k(j)+length(OrderedCharArray{i}));
        else
            after = ' ';
        end;
        if (ismember(after, Allowed) && ismember(before, Allowed))
            RevisedFormula = regexprep(RevisedFormula, OrderedCharArray{i}, OrderedReplacements{i}, j);
        end;
    end;
end;

y = RevisedFormula;


