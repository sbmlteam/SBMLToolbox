function WriteODEFunction(SBMLModel)
% WriteODEFunction takes a matlab sbml model structure and outputs a file
% defining a function for use with matlabs ode solvers

%
%  Filename    : WriteODEFunction.m
%  Description : takes a SBMLModel and outputs a file
%                   defining a function for use with matlabs ode solvers
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('WriteODEFunction(SBMLModel)\n%s', 'argument must be an SBMLModel structure');
end;

%------------------------------------------------------------
% look for rules/functions/events and warn user that these are not dealt with yet
Rules = length(SBMLModel.rule);
if (SBMLModel.SBML_level == 2)
    Funcs = length(SBMLModel.functionDefinition);
    Events = length(SBMLModel.event);
else
    Funcs = 0;
    Events = 0;
end;

if ((Rules ~= 0) || (Funcs ~= 0) || (Events ~= 0))
    disp('Note this procedure does not yet fully deal with rules, events or functions');
    disp('They will NOT be included in the calculation');
end;
% -------------------------------------------------------------

% get information from the model
[ParameterNames, ParameterValues] = GetAllParametersUnique(SBMLModel);
[SpeciesNames, SpeciesValues] = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
NumReactions = length(SBMLModel.reaction);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
 
    % if species is a boundary condition (or constant in level 2
    % no rate law is required
    % will need to adapt for rules
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
            
            SpeciesType = IsSpeciesInReaction(SBMLModel.species(i), SBMLModel.reaction(j));
            
            % record numbers of occurences of species as reactant/product 
            % and check that we can deal with reaction
            if (SpeciesType(1)>0)
                
                NoModifiers = length(SpeciesType);
                NoReactants = SpeciesType(2);
                NoProducts =  SpeciesType(3+NoReactants);
                SavedNoReactants = SpeciesType(2);
                
                %--------------------------------------------------------------
                % check that a species does not occur twice on one side of the
                % reaction
                if (NoReactants > 1 || NoProducts > 1)
                    error('WriteODEFunction(SBMLModel)\n%s', 'SPECIES OCCURS MORE THAN ONCE ON ONE SIDE OF REACTION');
                end;
                
                %--------------------------------------------------------------
                % check if species is a modifier and exit if it is
                if (SpeciesType(NoModifiers) > 0)
                    error('WriteODEFunction(SBMLModel)\n%s', 'CANNOT DEAL WITH MODIFIERS YET');
                end;
                %--------------------------------------------------------------
                % check that reaction has a kinetic law formula
                if (isempty(SBMLModel.reaction(j).kineticLaw))
                    error('WriteODEFunction(SBMLModel)\n%s', 'NO KINETC LAW SUPPLIED');
                end;
                %--------------------------------------------------------------
                
                
            end;
            
            % species has been found in this reaction
            while (SpeciesType(1) > 0) % 
                
                % add the kinetic law to the output for this species
                
                if(NoProducts > 0) 
                    
                    % Deal with case where parameter is defined within the reaction
                    % and thus the reaction name has been appended to the parameter
                    % name in the list in case of repeated use of same name
                    Param_Name = GetParameterFromReaction(SBMLModel.reaction(j));
                    
                    
                    if (~isempty(Param_Name))
                        ReviseParam_Name = GetParameterFromReactionUnique(SBMLModel.reaction(j));
                    end;
                    
                    formula = SBMLModel.reaction(j).kineticLaw.formula;
                    
                    formula = Substitute(Param_Name, ReviseParam_Name, formula);
                    
                    % if stoichiometry = 1 no need to include it in formula
                    if (SpeciesType(3+SavedNoReactants+1) == 1)
                        output = sprintf('%s + %s', output, formula);
                    else
                        output = sprintf('%s + %u * %s', output, SpeciesType(3+SavedNoReactants+1), formula);
                    end;
                    
                    NoProducts = NoProducts - 1;
                    
                elseif (NoReactants > 0) 
                    % DEAL WITH CASE WHERE KINETIC LAW LREADY HAS A MINUS SIGN    
                    % since any kinetic law here will be subtracted any
                    % existing minus signs must be replaced with plus
                    formula = regexprep(SBMLModel.reaction(j).kineticLaw.formula, '-', '+');
                    
                    % Deal with case where parameter is defined within the reaction
                    % and thus the reaction name has been appended to the parameter
                    % name in the list in case of repeated use of same name
                    Param_Name = GetParameterFromReaction(SBMLModel.reaction(j));
                    
                    if (~isempty(Param_Name))
                        ReviseParam_Name = GetParameterFromReactionUnique(SBMLModel.reaction(j));
                    end;
                    
                    formula = Substitute(Param_Name, ReviseParam_Name, formula);
                    
                    % if stoichiometry = 1 no need to include it in formula
                    if (SpeciesType(3) == 1)
                        output = sprintf('%s - %s', output, formula);
                    else
                        output = sprintf('%s - %u * %s', output, SpeciesType(3), formula);
                    end;
                    
                    NoReactants = NoReactants - 1;
                    
                end; 
                
                
                
                SpeciesType(1) = SpeciesType(1) - 1;
                
            end; % while found > 0
            
        end; % for NumReactions
        
    end; % if boundary condition
    
    
    % finished looking for this species
    % record rate law and loop to next species
    % put the species symbol if no law found
    if (isempty(output))
        RateLaws{i} = '0';%SpeciesNames{i};
    else
        RateLaws{i} = output;
    end;
    
end; % for NumSpecies


%---------------------------------------------------------------
% get the name/id of the model

Name = '';
if (SBMLModel.SBML_level == 1)
    Name = SBMLModel.name;
else
    if (isempty(SBMLModel.name))
        Name = SBMLModel.id;
    else
        Name = SBMLModel.name;
    end;
end;

fileName = strcat(Name, '.m');
%--------------------------------------------------------------------
% open the file for writing

fileID = fopen(fileName, 'w');

% write the function declaration
fprintf(fileID,  'function xdot = %s(time, x)\n', Name);

% need to add comments to output file
fprintf(fileID, '%% function %s takes\n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%% either\t1) no arguments\n');
fprintf(fileID, '%%       \t    and returns a vector of the initial species concentrations\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% or    \t2) time - the elapsed time since the beginning of the reactions\n');
fprintf(fileID, '%%       \t   x    - vector of the current concentrations of the species\n');
fprintf(fileID, '%%       \t    and returns a vector of the rate of change of concentration of each of the species\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% %s can be used with matlabs odeN functions as \n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%%\t[t,x] = ode23(@%s, [0, t_end], %s)\n', Name, Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%%\t\t\twhere  t_end is the end time of the simulation\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%%The species in this model are related to the output vectors with the following indices\n');
fprintf(fileID, '%%\tIndex\tSpecies name\n');
for i = 1:NumberSpecies
    fprintf(fileID, '%%\t  %u  \t  %s\n', i, SpeciesNames{i});
end;
fprintf(fileID, '%%\n');

% write the species concentration vector
fprintf(fileID, '%%--------------------------------------------------------\n');
fprintf(fileID, '%% output vector\n\n');


fprintf(fileID, 'xdot = zeros(%u, 1);\n', NumberSpecies);

% write the parameter values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% assign parameter values\n\n');

for i = 1:length(ParameterNames)
    fprintf(fileID, '%s = %i;\n', ParameterNames{i}, ParameterValues(i));
end;

% write code to calculate concentration values
% write the parameter values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% calculate concentration values\n\n');

fprintf(fileID, 'if (nargin == 0)\n');
fprintf(fileID, '\n\t%% initial concentrations\n');

for i = 1:NumberSpecies
    fprintf(fileID, '\txdot(%u) = %i;\n', i, SpeciesValues(i));
end;

fprintf(fileID, '\nelse\n');
fprintf(fileID, '\t%% deal with any assignments\n');
for i = 1:GetNumAssignmentRules(SBMLModel)
    % will need to modify this for models with more than one rule type
    rule = WriteRule(SBMLModel.rule(i));
    if (~isempty(rule))
        fprintf(fileID, '\t%s\n', rule);
    end;
end;
        

fprintf(fileID, '\t%% floating species concentrations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '\t%s = x(%u);\n', SpeciesNames{i}, i);
end;

fprintf(fileID, '\n\t%% species concentration equations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '\t%%%s\n', SpeciesNames{i});
    fprintf(fileID, '\txdot(%u) = %s;\n', i, RateLaws{i});
end;


fprintf(fileID, '\nend;\n');

fclose(fileID);

%--------------------------------------------------------------------------

function y = Substitute(InitialCharArray, ReplacementParams, Formula)

% get the number of parameters to be replced
NumberParams = length(InitialCharArray);


% want these in order of shortest to longest
% since shorter my be subsets of longer 
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

% determine that occurences of each Initial parameter in the formula
for i = 1:NumberParams
    Hits{i} = strfind(Formula, OrderedCharArray{i});
end;


for i = 1:NumberParams
    
    for j = 1:length(Hits{i})
        
        % check whether a member of later arrays
        % if so it is a subset ignore
        for k = i+1:NumberParams
            if (ismember(Hits{i}(j), Hits{k}))
                Hits{i}(j) = 0;
            else 
                for s = 1:length(Hits{k})
                    if ((Hits{i}(j) > Hits{k}(s)) && (Hits{i}(j) < Hits{k}(s) + NoCharsInParam(k)))
                        Hits{i}(j) = 0;
                    end;
                end;
            end;
        end;
    end;
end;

% determine the number of occurences of each parameter

 for i = 1:NumberParams
     Number(i) = length(find(Hits{i}~=0));
 end;
 
% create an index of the starting points
Index = {};
for i = 1:NumberParams
    
    TempIndex = [];
    for k = 1:length(Hits{i})
        if (Hits{i}(k) ~= 0)
            TempIndex = [TempIndex Hits{i}(k)];
        end;
    end;
     Index{i} = TempIndex;
end;

% replace the parameters in the formula starting with the shortest 

RevisedFormula = Formula;

for i = 1:NumberParams
    
    for k = 1:Number(i)
        
        % declare temporary
        NewFormula = '';
        Remainder = '';
        
        % get current length of formula
        CurrentLength = length(RevisedFormula);
    
        % copy from beginning of formula to point before parameter
        for j = 1:Index{i}(k)-1
            NewFormula(j) = RevisedFormula(j);
        end;
    
        % add the new parameter name
        NewFormula = strcat(NewFormula, char(OrderedReplacements{i}));
    
        % determine the limit of the remaining formula
        Limit = CurrentLength - NoCharsInParam(i)-Index{i}(k) + 1;
        
        % write formula after occurence of parameter and add to new formula
        for j = 1:Limit
            OldIndex = j + Index{i}(k) + NoCharsInParam(i) - 1;
            Remainder(j) = RevisedFormula(OldIndex);
        end;
        
        NewFormula = strcat(NewFormula, Remainder);
        
        % update index
        % length of formula has changed so locations have changed
        for j = i:NumberParams
            for s = 1:length(Index{j})
                if (Index{j}(s) > Index{i}(k))
                    Index{j}(s) = Index{j}(s) + length(OrderedReplacements{i}) - NoCharsInParam(i);
                end;
            end;
        end;
        
        RevisedFormula = '';
        RevisedFormula = NewFormula;
    end;
    
end;

y = RevisedFormula;

%-------------------------------------------------------------------------
function y = WriteRule(SBMLRule)

y = '';

% check that input is a rule
if (~isSBML_Rule(SBMLRule))
    error('WriteRule(SBMLRule)\n%s', 'first argument must be an SBMLRule structure');
end;
%------------------------------------------------------------

switch (SBMLRule.typecode)
    case 'SBML_ASSIGNMENT_RULE'
        y = sprintf('%s = %s;', SBMLRule.variable, SBMLRule.formula);
    otherwise
        error('No assignment rules');
end;