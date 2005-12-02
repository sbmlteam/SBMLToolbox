function WriteEventAssignmentFunction(SBMLModel)
% WriteEventAssignmentFunction takes a matlab sbml model structure and outputs a file
% defining a function that assigns values following an event for use with matlabs ode solvers

%
%  Filename    : WriteEventAssignmentFunction.m
%  Description : takes a SBMLModel and outputs a file
%                   defining a function that assigns values following an event for use with matlabs ode solvers
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2004-11-30
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
    error('WriteEventAssignmentFunction(SBMLModel)\n%s', 'argument must be an SBMLModel structure');
end;

% -------------------------------------------------------------

% get information from the model
[ParameterNames, ParameterValues] = GetAllParametersUnique(SBMLModel);
[SpeciesNames, SpeciesValues] = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);
NumFuncs = length(SBMLModel.functionDefinition);

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

Name = strcat(Name, '_eventAssign');

fileName = strcat(Name, '.m');
%--------------------------------------------------------------------
% open the file for writing

fileID = fopen(fileName, 'w');

% write the function declaration
fprintf(fileID,  'function Values = %s(%s, SpeciesValues)\n', Name, timeVariable);

% need to add comments to output file
fprintf(fileID, '%% function %s takes\n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%% current simulation time and\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% vector of current species values\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% and returns the values assigned by an event assignment\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% %s should be used with matlabs odeN functions\n', Name);
fprintf(fileID, '%% and called to reinitialise values when an event has stopped the integration\n');
fprintf(fileID, '%%\n');

fprintf(fileID, '\n');

% write the parameter values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% parameter values\n\n');

for i = 1:length(ParameterNames)
    fprintf(fileID, '%s = %i;\n', ParameterNames{i}, ParameterValues(i));
end;

% write the current species concentrations
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% floating species concentrations\n');
for i = 1:NumberSpecies
    fprintf(fileID, '%s = SpeciesValues(%u);\n', SpeciesNames{i}, i);
end;

% write the event assignments
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% event assignments\n\n');

for i = 1:length(SBMLModel.event)
    % need to determine which events have been triggered
    fprintf(fileID, 'if (%s)\n', SBMLModel.event(i).trigger);
    for j = 1:length(SBMLModel.event(i).eventAssignment)
        fprintf(fileID, '\t%s = %s;\n', SBMLModel.event(i).eventAssignment(j).variable, SBMLModel.event(i).eventAssignment(j).math);
    end;
    fprintf(fileID, 'end;\n');
end;

% output values
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% output values\n\n');
for i = 1:NumberSpecies
    fprintf(fileID, 'Values(%u) = %s;\n', i, SpeciesNames{i});
end;

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

