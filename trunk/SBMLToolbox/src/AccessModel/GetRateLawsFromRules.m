function [Species, RateLaws] = GetRateLawsFromRules(SBMLModel)
% GetRateLawsFromRules takes an SBMLModel 
% and returns
%             1) an array of species names
%             2) an array of the character representation of the rate laws
%             for each species from rules

%--------------------------------------------------------------------------
%
%  Filename    : GetRateLawsFromRules.m
%  Description : takes a SBMLModel and returns rate laws
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-11-12
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
    error('GetRateLawsFromRules(SBMLModel)\n%s', 'input must be an SBMLModel structure');
end;

%--------------------------------------------------------------
            
% get information from the model
Species = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
RateRules = GetRateRules(SBMLModel);
NumRateRules = GetNumRateRules(SBMLModel);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
 
    % if species is a boundary condition in level 1 (or constant in level 2
    % concentration cannot be changed by a rate rule
    boundary = SBMLModel.species(i).boundaryCondition;
    if (SBMLModel.SBML_level == 2)
        constant = SBMLModel.species(i).constant;
    else
        constant = -1;
    end;
    
    if (constant == 1)
        output = '0';
    elseif ((SBMLModel.SBML_level == 1) && (boundary == 1))
        output = '0';
    else
        
        %determine which rules it occurs within 
        j = 0;
        while (j <NumRateRules)
         
            if ((strcmp(Species(i), RateRules(j+1).variable)) | (strcmp(Species(i), RateRules(j+1).species)))
                output = RateRules(j+1).formula;
                break;
            else
                j = j + 1;
            end;
           
        end; % while NumRateRules
        
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

