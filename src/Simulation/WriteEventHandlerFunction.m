function WriteEventHandlerFunction(SBMLModel)
% WriteEventHandlerFunction takes a matlab sbml model structure and outputs a file
% defining a function for use with the event handler within matlabs ode solvers

%
%  Filename    : WriteODEFunction.m
%  Description : takes a SBMLModel and outputs a file
%                   defining a function for use with the event handler within matlabs ode solvers
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
    error('WriteEventHandlerFunction(SBMLModel)\n%s', 'argument must be an SBMLModel structure');
end;

% -------------------------------------------------------------

% get information from the model
[ParameterNames, ParameterValues] = GetAllParametersUnique(SBMLModel);
[SpeciesNames, SpeciesValues] = GetSpecies(SBMLModel);
NumberSpecies = length(SBMLModel.species);

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

Name = strcat(Name, '_events');

fileName = strcat(Name, '.m');
%--------------------------------------------------------------------
% open the file for writing

fileID = fopen(fileName, 'w');

% write the function declaration
fprintf(fileID,  'function [value,isterminal,direction] = %s(t, y)\n', Name);

% need to add comments to output file
fprintf(fileID, '%% function %s takes\n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%%\t1) current elapsed time of integration\n');
fprintf(fileID, '%%\t2) vector of current output values\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% and stops the integration if the value calculated is zero\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%% %s should be used with matlabs odeN functions as \n', Name);
fprintf(fileID, '%% the events function option\n');
fprintf(fileID, '%%\n');
fprintf(fileID, '%%\ti.e. options = odeset(''Events'', @%s)\n', Name);
fprintf(fileID, '%%\n');
fprintf(fileID, '%%\t[t,x] = ode23(@function, [0, t_end], function, options)\n');
fprintf(fileID, '%%\n');

fprintf(fileID, '\n');

fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% constant for use with < or >\neps = 1e-10;\n\n');

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
    fprintf(fileID, '%s = y(%u);\n', SpeciesNames{i}, i);
end;

% write the events
fprintf(fileID, '\n%%--------------------------------------------------------\n');
fprintf(fileID, '%% events - point at which value will return 0\n\n');

dirs = [];
fprintf(fileID, 'value = [');
for i = 1:length(SBMLModel.event)
    [Funcs, directions] = ParseTriggerFunction(SBMLModel.event(i).trigger);
    for j = 1:length(Funcs)
        if ((i > 1) || (j > 1))
            fprintf(fileID, ', %s', Funcs{j});
        else
            fprintf(fileID, '%s', Funcs{j});
        end;
    end;
    dirs = [dirs,directions];
end;
fprintf(fileID, '];\n');


fprintf(fileID, '\n%%stop integration\n');
fprintf(fileID, 'isterminal = [1');
for i = 2:length(dirs)
    fprintf(fileID, ', 1');
end;
fprintf(fileID, '];\n\n');

% this may depend on  model
fprintf(fileID, '%%set direction at which event should be looked for\n');
fprintf(fileID, 'direction = [%d', dirs(1));
for i = 2:length(dirs)
    fprintf(fileID, ', %d', dirs(i));
end;
fprintf(fileID, '];\n\n');


fclose(fileID);

%--------------------------------------------------------------------------
% other functions

function [FunctionStrings, direction] = ParseTriggerFunction(Trigger)

Trigger = LoseLeadingWhiteSpace(Trigger);

% trigger has the form function(function(variable,constant), function(v,c))
% need to isolate each
OpenBracket = strfind(Trigger, '(');
CloseBracket = strfind(Trigger, ')');

if (length(OpenBracket) == 1)
    % no subfunctions
    [FunctionStrings{1}, direction] = ParseTriggerSubFunction(Trigger);
else
    Func = Trigger(1:OpenBracket-1);

    Comma = strfind(Trigger, ',');

    if (length(OpenBracket) ~= length(Comma))
        error('Cannot handle this function');
    end;

    [Func1, dir1] = ParseTriggerSubFunction(Trigger(OpenBracket(1)+1:Comma(2)-1));
    [Func2, dir2] = ParseTriggerSubFunction(Trigger(Comma(2)+1:CloseBracket(2)));




    switch (Func)
        case 'and'
            FunctionStrings{1} = sprintf('(%s) * (%s)',Func1, Func2);
            direction = 0;
        case 'or'
            FunctionStrings{1} = Func1;
            FunctionStrings{2} = Func2;
            direction = [dir1, dir2];
        otherwise
            error('unrecognised function in trigger');
    end;

end;

function [FunctionString, direction] = ParseTriggerSubFunction(Trigger)

FunctionString = '';

Trigger = LoseLeadingWhiteSpace(Trigger);

% trigger has the form function(variable,constant)
% need to isolate each
Bracket = strfind(Trigger, '(');
Func = Trigger(1:Bracket-1);

Comma = strfind(Trigger, ',');
Variable = Trigger(Bracket+1:Comma-1);

Constant = Trigger(Comma+1:end-1);

% create the approriate function

switch (Func)
    case 'lt'
        FunctionString = sprintf('%s - %s + eps', Variable, Constant);
        direction = -1;
    case 'leq'
        FunctionString = sprintf('%s - %s', Variable, Constant);
        direction = -1;
    case 'gt'
        FunctionString = sprintf('%s - %s + eps', Constant, Variable );
         direction = 0;
   case 'geq'
        FunctionString = sprintf('%s - %s', Constant, Variable );
        direction = 0;
    otherwise
        error('unrecognised function in trigger');
end;

function y = LoseLeadingWhiteSpace(charArray)
% LoseLeadingWhiteSpace(charArray) takes an array of characters
% and returns the array with any leading white space removed
%
%----------------------------------------------------------------
% EXAMPLE:
%           y = LoseLeadingWhiteSpace('     example')
%           y = 'example'
%

%------------------------------------------------------------
% check input is an array of characters
if (~ischar(charArray))
    error('LoseLeadingWhiteSpace(input)\n%s', 'input must be an array of characters');
end;

%-------------------------------------------------------------
% get the length of the array
NoChars = length(charArray);

%-------------------------------------------------------------
% determine the number of leading spaces

% create an array that indicates whether the elements of charArray are
% spaces
% e.g. WSpace = isspace('  v b') = [1, 1, 0, 1, 0]

WSpace = isspace(charArray);

%       find the indices of elements that are 0
%       no spaces equals the index of the first zero minus 1
% e.g. Zeros = find(WSpace == 0) = [3,5]
%       NoSpaces = 2;

Zeros = find(WSpace == 0);

if (isempty(Zeros))
    NoSpaces = 0;
else
    NoSpaces = Zeros(1)-1;
end;

%-----------------------------------------------------------
% if there is leading white spaces rewrite the array to leave these out

if (NoSpaces > 0)
    for i = 1: NoChars-NoSpaces
        y(i) = charArray(i+NoSpaces);
    end;
else
    y = charArray;
end;


