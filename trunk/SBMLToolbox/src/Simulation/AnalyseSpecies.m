function Species = AnalyseSpecies(SBMLModel)
% AnalyseSpecies takes an SBMLmodel
% and returns
%           structure detailing the species and how they are manipulated 
%               within the model
% 
% the structure fields are
%     Name
%     SpeciesType (L2V2)
%     constant
%     boundaryCondition
%     initialValue
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
% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('AnalyseSpecies(SBMLModel)\n%s', 'argument must be an SBMLModel structure');
end;

[name, KineticLaw] = Model_determineRateLawsFromReactions(SBMLModel);
[n, RateRule] = Model_determineRateLawsFromRules(SBMLModel);
[n, AssignRule] = GetSpeciesAssignmentRules(SBMLModel);
[n, AlgRules] = GetSpeciesAlgebraicRules(SBMLModel);
[n, Values] = GetSpecies(SBMLModel);

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

    Species(i).initialValue = Values(i);
    
    if (SBMLModel.SBML_level == 2 && SBMLModel.species(i).isSetInitialConcentration == 1)
        Species(i).isConcentration = 1;
    else
        Species(i).isConcentration = 0;
    end;
    Species(i).compartment = SBMLModel.species(i).compartment;
    
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
            
            % need to look at whether rule contains a user definined
            % function
            FunctionIds = Model_getFunctionIds(SBMLModel);
            for f = 1:length(FunctionIds)
                if (strfind(char(Rule), FunctionIds{f}))
                    Rule = SubstituteFunction(char(Rule), SBMLModel.functionDefinition(f));
                end;
                
            end;
            
            SubsRule = SubsAssignmentRules(SBMLModel, char(Rule));
            Species(i).ConvertedRule = Rearrange(SubsRule, name{i});
        else
            Species(i).ConvertedToAssignRule = 0;
            Species(i).ConvertedRule = '';
        end;
    elseif ((isnan(Species(i).initialValue)) && (Species(i).InAlgebraicRule == 1) && (Species(i).ChangedByAssignmentRule == 0))
        error ('The model is over parameterised and the simulation cannot make decisions regarding rules');
    
    else
        Species(i).ConvertedToAssignRule = 0;
        Species(i).ConvertedRule = '';

    end;

end;


function form = SubsAssignmentRules(SBMLModel, rule)

[species, AssignRule] = GetSpeciesAssignmentRules(SBMLModel);
form = rule;
% bracket the species to be replaced
for i = 1:length(species)
    if (strfind(rule, species{i}))
        if (~strcmp(AssignRule{i}, '0'))
            form = strrep(form, species{i}, strcat('(', species{i}, ')'));
        end;
    end;
end;

for i = 1:length(species)
    if (strfind(rule, species{i}))
        if (~strcmp(AssignRule{i}, '0'))
            form = strrep(form, species{i}, AssignRule{i});
        end;
    end;
end;
function output = Arrange(formula, x, vars)


ops = '+-';
f = LoseWhiteSpace(formula);

operators = ismember(f, ops);
OpIndex = find(operators == 1);

%--------------------------------------------------
% divide formula up into elements seperated by +/-
if (OpIndex(1) == 1)
    % leading sign i.e. +x-y
    NumElements = length(OpIndex);
    j = 2;
    index = 2;
else
    NumElements = length(OpIndex) + 1;
    j = 1;
    index = 1;
end;


for i = 1:NumElements-1

    element = '';

    while (j < OpIndex(index))
        element = strcat(element, f(j));
        j = j+1;
    end;
    Elements{i} = element;
    j = j + 1;
    index = index + 1;
end;

% get last element
j = OpIndex(end)+1;
element = '';

while (j <= length(f))
    element = strcat(element, f(j));
    j = j+1;
end;
Elements{NumElements} = element;

%--------------------------------------------------
% check whether element contains x
% if does keep on lhs else move to rhs changing sign
output = '';
lhs = 1;
for i = 1:NumElements
    if (strfind(Elements{i}, x))
        % element contains x
        LHSElements{lhs} = Elements{i};

        if (OpIndex(1) == 1)
            LHSOps(lhs) = f(OpIndex(i));
        elseif (i == 1)
            LHSOps(lhs) = '+';
        else
            LHSOps(lhs) = f(OpIndex(i-1));
        end;

        lhs = lhs + 1;
    elseif (i == 1)
        % first element does not contain x

        if (OpIndex(1) == 1)
            if (strcmp(f(1), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;

        else
            % no sign so +
            output = strcat(output, '-');
        end;
        output = strcat(output, Elements{i});
    else
        % element not first and does not contain x
        if (OpIndex(1) == 1)
            if (strcmp(f(OpIndex(i)), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;

        else
           if (strcmp(f(OpIndex(i-1)), '-'))
                output = strcat(output, '+');
            else
                output = strcat(output, '-');
            end;
        end;
        
        output = strcat(output, Elements{i});

   end;

end;

%------------------------------------------------------
% look at remaining LHS
for i = 1:length(LHSElements)
    Mult{i} = ParseElement(LHSElements{i}, x);
end;

if (length(LHSElements) == 1)
    % only one element with x
    % check signs and multipliers
    if (strcmp(LHSOps(1), '-'))
        output = strcat('-(', output, ')');
    end;
    
    if (~strcmp(Mult{1}, '1'))
        output = strcat(output, '/', Mult{1});
    end;
else
    divisor = '';
    if (strcmp(LHSOps(1), '+'))
        divisor = strcat(divisor, '(', Mult{1});
    else
         divisor = strcat(divisor, '(-', Mult{1});
    end;
    
    for i = 2:length(LHSElements)
        divisor = strcat(divisor, LHSOps(i), Mult{i});
    end;
    divisor = strcat(divisor, ')');
    output = strcat('(', output, ')/', divisor);
end;
    
function multiplier = ParseElement(element, x)

% assumes that the element is of the form n*x/m
% and returns n/m in simplest form

if (strcmp(element, x))
    multiplier = '1';
    return;
end;

VarIndex = strfind(element, x);
MultIndex = strfind(element, '*');
DivIndex = strfind(element, '/');

if (isempty(MultIndex))
    MultIndex = 1;
end;

if (isempty(DivIndex))
    DivIndex = length(element);
end;

if ((DivIndex < MultIndex) ||(VarIndex < MultIndex) || (VarIndex > DivIndex)) 
    error('Cannot deal with formula in this form');
end;

n = '';
m = '';

for i = 1:MultIndex-1
    n = strcat(n, element(i));
end;
if (isempty(n))
    n = '1';
end;

for i = DivIndex+1:length(element)
    m = strcat(m, element(i));
end;
if (isempty(m))
    m = '1';
end;

% if both m and n represenet numbers then they can be simplified

Num_n = str2num(n);
Num_m = str2num(m);

if (~isempty(Num_n) && ~isempty(Num_m))
    multiplier = num2str(Num_n/Num_m);
else
    if (strcmp(m, '1'))
        multiplier = n;
    else
    multiplier = strcat(n, '/', m);
    end;
end;

function y = LoseWhiteSpace(charArray)
% LoseWhiteSpace(charArray) takes an array of characters
% and returns the array with any white space removed
%
%----------------------------------------------------------------
% EXAMPLE:
%           y = LoseWhiteSpace('     exa  mp le')
%           y = 'example'
%

%------------------------------------------------------------
% check input is an array of characters
if (~ischar(charArray))
    error('LoseWhiteSpace(input)\n%s', 'input must be an array of characters');
end;

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

%-------------------------------------------------------------
% create an array that indicates whether the elements of charArray are
% spaces
% e.g. WSpace = isspace('  v b') = [1, 1, 0, 1, 0]
% and determine how many

WSpace = isspace(charArray);
NoSpaces = sum(WSpace);

%-----------------------------------------------------------
% rewrite the array to leaving out any spaces
% remove any numbers from the array of symbols
if (NoSpaces > 0)
    NewArrayCount = 1;
    for i = 1:NoChars
        if (~isspace(charArray(i)))
            y(NewArrayCount) = charArray(i);
            NewArrayCount = NewArrayCount + 1;
        end;
    end;    
else
    y = charArray;
end;

