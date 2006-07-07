function WriteODEFunction(varargin)
% WriteODEFunction takes 
%               1) an SBMLModel
%               2) a filename (optional)
% and outputs 
%       a file defining a function for use with MATLABs ode solvers
%
%  NOTE: if no filename is supplied the model id is used

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

switch (nargin)
    case 0
        error('WriteODEFunction(SBMLModel, (optional) filename)\n%s', 'must have at least one argument');
    case 1
        SBMLModel = varargin{1};
        filename = '';
    case 2
        SBMLModel = varargin{1};
        filename = varargin{2};
    otherwise
        error('WriteODEFunction(SBMLModel, (optional) filename)\n%s', 'does not take more than two arguments');
end;

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('WriteODEFunction(SBMLModel, (optional) filename)\n%s', 'first argument must be an SBMLModel structure');
end;

% -------------------------------------------------------------
% get information from the model

[ParameterNames, ParameterValues] = GetAllParametersUnique(SBMLModel);
Species = AnalyseSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
Speciesnames = GetSpecies(SBMLModel);
[CompartmentNames, CompartmentValues] = GetCompartments(SBMLModel);

if (SBMLModel.SBML_level == 2)
    NumEvents = length(SBMLModel.event);
    NumFuncs = length(SBMLModel.functionDefinition);

    % version 2.0.2 adds the time_symbol field to the model structure
    % need to check that it exists
    if (isfield(SBMLModel, 'time_symbol'))
        if (~isempty(SBMLModel.time_symbol))
            timeVariable = SBMLModel.time_symbol;
        else
            timeVariable = 'time';
        end;
    else
        timeVariable = 'time';
    end;

else
    NumEvents = 0;
    NumFuncs = 0;
    timeVariable = 'time';
end;

%---------------------------------------------------------------
% get the name/id of the model

Name = '';
if (SBMLModel.SBML_level == 1)
    Name = SBMLModel.name;
else
    if (isempty(SBMLModel.id))
        Name = SBMLModel.name;
    else
        Name = SBMLModel.id;
    end;
end;

if (~isempty(filename))
    Name = filename;
elseif (length(Name) > 63)
    Name = Name(1:60);
end;

fileName = strcat(Name, '.m');
%--------------------------------------------------------------------
% open the file for writing

fileID = fopen(fileName, 'w');

% write the function declaration
fprintf(fileID,  'function xdot = %s(%s, x_values)\n', Name, timeVariable);

% need to add comments to output file
fprintf(fileID, '%% function %s takes\n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%% either\t1) no arguments\n');
fprintf(fileID, '%%       \t    and returns a vector of the initial species concentrations\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% or    \t2) time - the elapsed time since the beginning of the reactions\n');
fprintf(fileID, '%%       \t   x_values    - vector of the current concentrations of the species\n');
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
    fprintf(fileID, '%%\t  %u  \t  %s\n', i, char(Species(i).Name));
end;
fprintf(fileID, '%%\n');

% write the species concentration vector
fprintf(fileID, '%%--------------------------------------------------------\n');
fprintf(fileID, '%% output vector\n\n');


fprintf(fileID, 'xdot = zeros(%u, 1);\n', NumberSpecies);

% write the compartment values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% compartment values\n\n');

for i = 1:length(CompartmentNames)
    fprintf(fileID, '%s = %i;\n', CompartmentNames{i}, CompartmentValues(i));
end;

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

for i = 1:NumberSpecies
    fprintf(fileID, '\t%s = %i;\n', char(Species(i).Name), Species(i).initialValue);
end;

fprintf(fileID, '\nelse\n');

fprintf(fileID, '\t%% floating species concentrations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '\t%s = x_values(%u);\n', char(Species(i).Name), i);
end;

fprintf(fileID, '\nend;\n');

% write assignment rules
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% assignment rules\n');


AssignRules = Model_getListOfAssignmentRules(SBMLModel);
for i = 1:length(AssignRules)
     rule = WriteRule(AssignRules(i));
     fprintf(fileID, '%s\n', rule);
end;

% write algebraic rules        
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% algebraic rules\n');

for i = 1:NumberSpecies
    if (Species(i).ConvertedToAssignRule == 1)
        fprintf(fileID, '%s = %s;\n', char(Species(i).Name), Species(i).ConvertedRule);
    end;
end;

% write code to calculate concentration values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% calculate concentration values\n\n');

fprintf(fileID, 'if (nargin == 0)\n');
fprintf(fileID, '\n\t%% initial concentrations\n');

% need to catch any initial concentrations that are not set
% and case where an initial concentration is set but is incosistent with a
% later rule

for i = 1:NumberSpecies

    if (Species(i).ChangedByAssignmentRule == 0)

        % not set by rule - use value given
        if (isnan(Species(i).initialValue))                      
            error('WriteODEFunction(SBMLModel)\n%s', 'species concentration not provided or assigned by rule');
         else
            fprintf(fileID, '\txdot(%u) = %i;\n', i, Species(i).initialValue);
        end;

    else

        % initial concentration set by rule
        fprintf(fileID, '\txdot(%u) = %s;\n', i, char(Species(i).Name));

   end;
end; % for NumSpecies

fprintf(fileID, '\nelse\n');

fprintf(fileID, '\n\t%% species concentration rate equations\n');
NeedToOrderArray = 0;
for i = 1:NumberSpecies

    if (Species(i).ChangedByReaction == 1)
        % need to look for piecewise functions
        if (isempty(strfind(char(Species(i).KineticLaw), 'piecewise')))
            if (Species(i).isConcentration == 1)
                Array{i} = sprintf('\txdot(%u) = (%s)/%s;\n', i, char(Species(i).KineticLaw), Species(i).compartment);
            else
                Array{i} = sprintf('\txdot(%u) = %s;\n', i, char(Species(i).KineticLaw));
            end;

        else
            %%TODO deal with nested piecewise
            var = sprintf('xdot(%u)', i);
            Array{i} = WriteOutPiecewise(var, char(Species(i).KineticLaw));
%             
%             Arguments = DealWithPiecewise(char(Species(i).KineticLaw));
% 
%             Array{i} = sprintf('\tif (%s) \n\t\txdot(%u) = %s;\n\telse\n\t\txdot(%u) = %s;\n\tend;\n', Arguments{2}, i, Arguments{1}, i, Arguments{3});
% 
        end;

    elseif (Species(i).ChangedByRateRule == 1)
        Array{i} = sprintf('\txdot(%u) = %s;\n', i, char(Species(i).RateRule));

    elseif (Species(i).ChangedByAssignmentRule == 1)
        % here no rate law has been provided by either kinetic law or rate
        % rule - need to check whether the species is in an
        % assignment rule which may impact on the rate

        %%% Checking for a piecewise in the assignment rule and
        %%% handling it
        %%% Change made by Sumant Turlapati, Entelos, Inc. on June 8th, 2005
        if (isempty(strfind(char(Species(i).AssignmentRule), 'piecewise')))
            DifferentiatedRule = DifferentiateRule(char(Species(i).AssignmentRule), Speciesnames);
            Array{i} = sprintf('\txdot(%u) = %s;\n', i, char(DifferentiatedRule));
            NeedToOrderArray = 1;
        else
%                 error('WriteODEFunction(SBMLModel)\n%s', 'cannot yet deal with a piecewise function within an assignment rule');
            %char(Species(i).AssignmentRule)
            %% taken out as this did not fully handle piecewise in an
            %% assignment rule
            Args = DealWithPiecewise(char(Species(i).AssignmentRule));

            DiffRule1 = DifferentiateRule(char(Args{1}), Speciesnames);
            DiffRule2 = DifferentiateRule(char(Args{3}), Speciesnames);
            Array{i} = sprintf('\tif (%s) \n\t\txdot(%d) = %s;\n\telse\n\t\txdot(%u) = %s;\n\tend;\n', Args{2}, i, char(DiffRule1), i, char(DiffRule2));
       %     NeedToOrderArray = 1;
        end;
        %DifferentiatedRule = DifferentiateRule(char(Species(i).AssignmentRule), Speciesnames);
        %Array{i} = sprintf('\txdot(%u) = %s;\n', i, char(DifferentiatedRule));
        %NeedToOrderArray = 1;

    elseif (Species(i).ConvertedToAssignRule == 1)
        % here no rate law has been provided by either kinetic law or rate
        % rule - need to check whether the species is in an
        % algebraic rule which may impact on the rate
        DifferentiatedRule = DifferentiateRule(char(Species(i).ConvertedRule), Speciesnames);
        Array{i} = sprintf('\txdot(%u) = %s;\n', i, char(DifferentiatedRule));
        NeedToOrderArray = 1;
    else
        % not set by anything
        Array{i} = sprintf('\txdot(%u) = 0;\n', i);

    end;
end; % for Numspecies

% need to check that assignments are made in appropriate order
% deals with rules that have been differentiated where xdot may occur on
% both sides of an equation
if (NeedToOrderArray == 1)
    Array = OrderArray(Array);
end;
for i = 1:NumberSpecies
    fprintf(fileID, '%s', Array{i});
end;



fprintf(fileID, '\nend;\n');

% put in any function definitions

if (NumFuncs > 0)
    fprintf(fileID, '\n\n%%---------------------------------------------------\n%%Function definitions\n\n');

    for i = 1:NumFuncs
        Name = SBMLModel.functionDefinition(i).id;

        Elements = GetArgumentsFromLambdaFunction(SBMLModel.functionDefinition(i).math);

        fprintf(fileID, '%%function %s\n\n', Name);
        fprintf(fileID, 'function returnValue = %s(', Name);
        for j = 1:length(Elements)-1
            if (j == length(Elements)-1)
            fprintf(fileID, '%s', Elements{j});
            else
                fprintf(fileID, '%s, ', Elements{j});
            end;
        end;
        fprintf(fileID, ')\n\nreturnValue = %s;\n\n\n', Elements{end});
    end;

end;


fclose(fileID);

% -----------------------------------------------------------------

if (NumEvents > 0)
% write two additional files for events

    WriteEventHandlerFunction(SBMLModel);
    WriteEventAssignmentFunction(SBMLModel);

end;


%--------------------------------------------------------------------------

function y = WriteRule(SBMLRule)

y = '';


switch (SBMLRule.typecode)
    case 'SBML_ASSIGNMENT_RULE'
    %%% Checking for a piecewise in the assignment rule and
        %%% handling it
        %%% Change made by Sumant Turlapati, Entelos, Inc. on June 8th, 2005
        if (isempty(strfind(char(SBMLRule.formula), 'piecewise')))
            y = sprintf('%s = %s;', SBMLRule.variable, SBMLRule.formula);
        else
            Arguments = DealWithPiecewise(char(SBMLRule.formula));
            y = sprintf('\tif (%s) \n\t\t%s = %s;\n\telse\n\t\t%s = %s;\n\tend;\n', Arguments{2}, SBMLRule.variable, Arguments{1}, SBMLRule.variable, Arguments{3});
        end;
%         y = sprintf('%s = %s;', SBMLRule.variable, SBMLRule.formula);
    case 'SBML_SPECIES_CONCENTRATION_RULE'
        y = sprintf('%s = %s;', SBMLRule.species, SBMLRule.formula);
    case 'SBML_PARAMETER_RULE'
        y = sprintf('%s = %s;', SBMLRule.name, SBMLRule.formula);

    otherwise
        error('No assignment rules');
end;

%--------------------------------------------------------------------------
function formula = DifferentiateRule(f, SpeciesNames)

Brackets = PairBrackets(f);

Dividers = '+-';
Divide = ismember(f, Dividers);

% dividers between brackets do not count
if (Brackets ~= 0)
    [NumPairs,y] = size(Brackets);
for i = 1:length(Divide)
    if (Divide(i) == 1)
        for j = 1:NumPairs
            if ((i > Brackets(j,1)) && (i < Brackets(j, 2)))
                Divide(i) = 0;
            end;
        end;
    end;
end;
end;    

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
    % need to catch case where element is number and
    % species names use numbers eg s3 element '3'
    for j = 1:length(SpeciesNames)
        %     j = 1;
        A = strfind(Elements{i}, SpeciesNames{j});
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

        Power = strfind(Elements{i}, '^');
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


%--------------------------------------------------------------------------
% function to put rate assignments in appropriate order
% eg
%       xdot(2) = 3
%       xdot(1) = 3* xdot(2)

function Output = OrderArray(Array)

% if (length(Array) > 9)
%     error('cannot deal with more than 10 species yet');
% end;

NewArrayIndex = 1;
TempArrayIndex = 1;
TempArray2Index = 1;
NumberInNewArray = 0;
NumberInTempArray = 0;
NumberInTempArray2 = 0;
TempArray2 = {};

% put any formula withoutxdot on RHS into new array
for i = 1:length(Array)
    if (length(strfind(Array{i}, 'xdot'))> 1)
        % xdot occurs more than once
        % put in temp array
        TempArray{TempArrayIndex} = Array{i};
        TempArrayIndices(TempArrayIndex) = i;

        % update
        TempArrayIndex = TempArrayIndex + 1;
        NumberInTempArray = NumberInTempArray + 1;

    else
        % no xdot on RHS
        % put in New array
        NewArray{NewArrayIndex} = Array{i};
        NewArrayIndices(NewArrayIndex) = i;

        % update
        NewArrayIndex = NewArrayIndex + 1;
        NumberInNewArray = NumberInNewArray + 1;


    end;
end;

while (NumberInTempArray > 0)
    % go thru temp array
    for i = 1:NumberInTempArray
        % find positions of xdot
        Xdot = strfind(TempArray{i}, 'xdot');

        % check whether indices of xdot on RHS are already in new array
        Found = 0;
        for j = 2:length(Xdot)
            Number = str2num(TempArray{i}(Xdot(j)+5));
            if (sum(ismember(NewArrayIndices, Number)) == 1)
                Found = 1;
            else
                Found = 0;
            end;
        end;

        % if all have been found put in new array
        if (Found == 1)
            % put in New array
            NewArray{NewArrayIndex} = TempArray{i};
            NewArrayIndices(NewArrayIndex) = TempArrayIndices(i);

            % update
            NewArrayIndex = NewArrayIndex + 1;
            NumberInNewArray = NumberInNewArray + 1;

        else
            % put in temp array2
            TempArray2{TempArray2Index} = TempArray{i};
            TempArray2Indices(TempArray2Index) = TempArrayIndices(i);

            % update
            TempArray2Index = TempArray2Index + 1;
            NumberInTempArray2 = NumberInTempArray2 + 1;


        end;



    end;

    %Realloctate temp arrays

    if (~isempty(TempArray2))
        TempArray = TempArray2;
        TempArrayIndices = TempArray2Indices;
        NumberInTempArray = NumberInTempArray2;
        TempArray2Index = 1;
        NumberInTempArray2 = 0;
    else
        NumberInTempArray = 0;
    end;




end; % of while NumInTempArray > 0

Output = NewArray;


function output = WriteOutPiecewise(var, formula)
            
Arguments = DealWithPiecewise(formula);

if (strfind('piecewise', Arguments{2}))
    error('Cant do this yet!');
end;

Text1{1} = sprintf('\n\tif (%s)', Arguments{2});

if (strfind(Arguments{1}, 'piecewise'))
    Text1{2} = WriteOutPiecewise(var, Arguments{1});
else
    Text1{2} = sprintf('\n\t\t%s = %s;', var, Arguments{1});
end;
Text1{3} = sprintf('\n\telse');

if (strfind('piecewise', Arguments{3}))
    Text1{4} = WriteOutPiecewise(var, Arguments{3});
else
    Text1{4} = sprintf('\n\t\t%s = %s;\n\tend;\n', var, Arguments{3});
end;

output = Text1{1};
for (i = 2:4)
    output = strcat(output, Text1{i});
end;


