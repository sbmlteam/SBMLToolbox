function WriteODEFunction(SBMLModel)
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
%
%
% WriteODEFunction takes a matlab sbml model structure and outputs a file
% defining a function for use with matlabs ode solvers


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
    disp('Note this procedure does not yet deal with rules, events or functions');
    disp('They will NOT be included in the calculation');
end;
% -------------------------------------------------------------

% get information from the model
[ParameterNames, ParameterValues] = GetAllParameters(SBMLModel);
[SpeciesNames, SpeciesValues] = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
NumReactions = length(SBMLModel.reaction);

% for each species loop through each reaction and determine whether the species
% takes part and in what capacity

for i = 1:NumberSpecies
    output = '';
    
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
                
                % if stoichiometry = 1 no need to include it in formula
                if (SpeciesType(3+SavedNoReactants+1) == 1)
                    output = sprintf('%s + %s', output, SBMLModel.reaction(j).kineticLaw.formula);
                else
                    output = sprintf('%s + %u * %s', output, SpeciesType(3+SavedNoReactants+1), SBMLModel.reaction(j).kineticLaw.formula);
                end;
                
                 NoProducts = NoProducts - 1;
                 
             elseif (NoReactants > 0) 
 % NEED TO DEAL WITH CASE WHERE KINETIC LAW LREADY HAS A MINUS SIGN    
                % since any kinetic law here will be subtracted any
                % existing minus signs must be replaced with plus
                formula = regexprep(SBMLModel.reaction(j).kineticLaw.formula, '-', '+');
                
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
    
    % finished looking for this species
    % record rate law and loop to next species
    % put the species symbol if no law found
    if (isempty(output))
        RateLaws{i} = SpeciesNames{i};
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