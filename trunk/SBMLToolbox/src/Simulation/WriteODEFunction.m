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

[a, RateLaws] = GetRateLawsFromReactions(SBMLModel);

[a, RateRules] = GetRateLawsFromRules(SBMLModel);

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
fprintf(fileID, '%% parameter values\n\n');

for i = 1:length(ParameterNames)
    fprintf(fileID, '%s = %i;\n', ParameterNames{i}, ParameterValues(i));
end;

% write the initial concentration values for the species
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% initial species values - these may be overridden by assignment rules\n\n');

fprintf(fileID, 'if (nargin == 0)\n');
fprintf(fileID, '\n\t%% initial concentrations\n');

for i = 1:length(SpeciesNames)
    fprintf(fileID, '\t%s = %i;\n', SpeciesNames{i}, SpeciesValues(i));
end;

fprintf(fileID, '\nelse\n');

fprintf(fileID, '\t%% floating species concentrations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '\t%s = x(%u);\n', SpeciesNames{i}, i);
end;

fprintf(fileID, '\nend;\n');

% write assignment rules
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% assignment rules\n');


AssignRules = GetAssignmentRules(SBMLModel);
for i = 1:length(AssignRules)
     rule = WriteRule(AssignRules(i));
     fprintf(fileID, '%s\n', rule);
end;

        

% write code to calculate concentration values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% calculate concentration values\n\n');

fprintf(fileID, 'if (nargin == 0)\n');
fprintf(fileID, '\n\t%% initial concentrations\n');
    
% need to catch any initial concentrations that are not set
% and case where an initial concentration is set but is incosistent with a
% later rule
NotSet = isnan(SpeciesValues);

for i = 1:NumberSpecies

    % get assignment rule if exists for the species
    if (length(SBMLModel.rule) ~= 0)
        RuleNo = IsSpeciesAssignedByRule(SBMLModel.species(i), SBMLModel.rule);
    else
        RuleNo = 0;
    end;
        
        
    if (RuleNo == 0)
        % not set by rule - use value given
        if (NotSet(i) == 1)
            error('WriteODEFunction(SBMLModel)\n%s', 'species concentration not provided or assigned by rule');

        else
            fprintf(fileID, '\txdot(%u) = %i;\n', i, SpeciesValues(i));

        end;
    else
        % initial concentration set by rule
        fprintf(fileID, '\txdot(%u) = %s;\n', i, SpeciesNames{i});

   end;
end; % for NumSpecies

fprintf(fileID, '\nelse\n');

fprintf(fileID, '\n\t%% species concentration rate equations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '\t%%%s\n', SpeciesNames{i});
    
    % check whether rate defined by kinetic law or rule
    KL = strcmp(RateLaws{i}, '0');
    R = strcmp(RateRules{i}, '0');
    
    if ((KL ~= 1) & (R ~= 1))
        error('WriteODEFunction(SBMLModel)\n%s', 'rates provided by rule and kinetic law');
    elseif ((KL == 1) & (R == 0))
        fprintf(fileID, '\txdot(%u) = %s;\n', i, RateRules{i});
    elseif ((R == 1) & (KL == 0)) 
        fprintf(fileID, '\txdot(%u) = %s;\n', i, RateLaws{i});
    else
        % here no rate law has been provided by either kinetic law or rate
        % rule - need to check whether the species concenrn is in an
        % assignment rule which may impact on the rate
        if (length(SBMLModel.rule) ~= 0)
            RuleNo = IsSpeciesAssignedByRule(SBMLModel.species(i), SBMLModel.rule);
        else
            RuleNo = 0;
        end;
        if (RuleNo == 0)
            % not set by assignment 
            fprintf(fileID, '\txdot(%u) = 0;\n', i);
        else
            DifferentiatedRule = DifferentiateRule(SBMLModel.rule(RuleNo), SpeciesNames);
            fprintf(fileID, '\txdot(%u) = %s;\n', i, DifferentiatedRule{1});
        end;
    end;

end;


fprintf(fileID, '\nend;\n');

fclose(fileID);

%--------------------------------------------------------------------------

function y = WriteRule(SBMLRule)

y = '';


switch (SBMLRule.typecode)
    case 'SBML_ASSIGNMENT_RULE'
        y = sprintf('%s = %s;', SBMLRule.variable, SBMLRule.formula);
    case 'SBML_SPECIES_CONCENTRATION_RULE'
        y = sprintf('%s = %s;', SBMLRule.species, SBMLRule.formula);
    case 'SBML_PARAMETER_RULE'
        y = sprintf('%s = %s;', SBMLRule.name, SBMLRule.formula);

    otherwise
        error('No assignment rules');
end;

%--------------------------------------------------------------------------
function formula = DifferentiateRule(SBMLRule, SpeciesNames)

f = SBMLRule.formula;

Dividers = '+-';

Divide = ismember(f, Dividers);
Divider = '';
NoElements = 1;
element = '';
for i = 1:length(f)
    if (Divide(i) == 0)
        element = strcat(element, f(i));
    else
        Divider = strcat(Divider, f(i));
        Elements{NoElements} = element;
        NoElements = NoElements + 1;
        element = '';
    end;
    
    % catch last element
    if (i == length(f))
        Elements{NoElements} = element;
    end;
end;

for i = 1:NoElements
    % check whether element contains a species name
    for j = 1:length(SpeciesNames)
        %     j = 1;
        A = findstr(SpeciesNames{j}, Elements{i});
        if (~isempty(A))
            break;
        end;
    end;
    
    if (isempty(A))
        % this element does not contain a species
        Elements{i} = strrep(Elements{i}, Elements{i}, '0');
    else
        % this element does contain a species
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % WHAT IF MORE THAN ONE SPECIES
        
        % for moment assume this would not happen
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        Power = findstr(Elements{i}, '^');
        if (~isempty(Power))
            Number = '';
            Digits = isstrprop(Elements{i}, 'digit');
            
            k = Power+1;
            while ((k < (length(Elements{i})+1)) & (Digits(k) == 1))
              Number = strcat(Number, Elements{i}(k));
              k = k + 1;
            end;
            
            Index = str2num(Number); 
            
            
            
            Replace = sprintf('%u * %s^%u*xdot(%u)', Index, SpeciesNames{j}, Index-1, j);
            Initial = sprintf('%s^%u', SpeciesNames{j}, Index);
            Elements{i} = strrep(Elements{i}, Initial, Replace);
        else
        
        Replace = sprintf('xdot(%u)', j);
         Elements{i} = strrep(Elements(i), SpeciesNames{j}, Replace);
        
       end;
    end;
end;

% put the formula back together
formula = '';
for i = 1:NoElements-1
    formula = strcat(formula, Elements{i}, Divider(i));
end;
formula = strcat(formula, Elements{NoElements});