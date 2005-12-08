function WriteEventHandlerFunction(SBMLModel)
% WriteEventHandlerFunction takes an SBMLModel
% and outputs 
%       a file defining a function that handles an avent
%       (for use with the event option in matlabs ode solvers)

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

Name = strcat(Name, '_events');

fileName = strcat(Name, '.m');
%--------------------------------------------------------------------
% open the file for writing

fileID = fopen(fileName, 'w');

% write the function declaration
fprintf(fileID,  'function [value,isterminal,direction] = %s(%s, y)\n', Name, timeVariable);

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

numOfFunctions = 0 ;
fprintf(fileID, 'value = [');
for i = 1:length(SBMLModel.event)
    [Funcs, Ignored] = ParseTriggerFunction(SBMLModel.event(i).trigger,[]);
    for j = 1:length(Funcs)
        numOfFunctions = numOfFunctions + 1;
        %fprintf(1, '%s\n', Funcs{j});
        if ((i > 1) || (j > 1))
            fprintf(fileID, ', %s', Funcs{j});
        else
            fprintf(fileID, '%s', Funcs{j});
        end;
    end;
end;
fprintf(fileID, '];\n');


fprintf(fileID, '\n%%stop integration\n');
fprintf(fileID, 'isterminal = [1');
for i = 2:numOfFunctions
    fprintf(fileID, ', 1');
end;
fprintf(fileID, '];\n\n');

% this may depend on  model
fprintf(fileID, '%%set direction at which event should be looked for\n');
fprintf(fileID, 'direction = [-1');
for i = 2:numOfFunctions
    fprintf(fileID, ', -1');
end;
fprintf(fileID, '];\n\n');


fclose(fileID);

%--------------------------------------------------------------------------
% other functions

function [FunctionStrings, Trigger] = ParseTriggerFunction(Trigger, FunctionStrings)

%fprintf(1,'parsing: %s\n', Trigger);

Trigger = LoseLeadingWhiteSpace(Trigger);

% trigger has the form function(function(variable,constant), function(v,c))
% need to isolate each
OpenBracket = strfind(Trigger, '(');

Func = Trigger(1:OpenBracket-1);
Trigger = Trigger(OpenBracket+1:length(Trigger));

%fprintf(1,'got function: %s\n', Func);

    switch (Func)
        case 'and'
            [FunctionStrings, Trigger] = ParseTwoArgumentsAndClose(Trigger, FunctionStrings);
        case 'or'
            [FunctionStrings, Trigger] = ParseTwoArgumentsAndClose(Trigger, FunctionStrings);
        case 'lt'
            [left, right, Trigger] = ParseTwoNumericArgumentsAndClose(Trigger);
            FunctionString = sprintf('(%s) - (%s) + eps', left, right);
            FunctionStrings{length(FunctionStrings)+1} = FunctionString;
        case 'le'
            [left, right, Trigger] = ParseTwoNumericArgumentsAndClose(Trigger); 
            FunctionString = sprintf('(%s) - (%s)', left, right);
            FunctionStrings{length(FunctionStrings)+1} = FunctionString;
        case 'gt'
            [left, right, Trigger] = ParseTwoNumericArgumentsAndClose(Trigger);
            FunctionString = sprintf('(%s) - (%s) + eps', right, left);
            FunctionStrings{length(FunctionStrings)+1} = FunctionString;
        case 'ge'
            [left, right, Trigger] = ParseTwoNumericArgumentsAndClose(Trigger);
            FunctionString = sprintf('(%s) - (%s)', right, left);
            FunctionStrings{length(FunctionStrings)+1} = FunctionString;
        otherwise
            error(sprintf('unrecognised function %s in trigger', Func));
    end;



function [FunctionStrings, Trigger] = ParseTwoArgumentsAndClose(Trigger, FunctionStrings)
    %fprintf(1, 'In ParseTwoArgumentsAndClose parsing: %s\n', Trigger);
    [FunctionStrings, Trigger] = ParseTriggerFunction(Trigger, FunctionStrings);
    comma = strfind(Trigger, ',');
    [FunctionStrings, Trigger] = ParseTriggerFunction(Trigger(comma+1:length(Trigger)), FunctionStrings);
    closeBracket = strfind(Trigger, ')');
    Trigger = Trigger(closeBracket+1:length(Trigger));


function [left, right, Trigger] = ParseTwoNumericArgumentsAndClose(Trigger)
    [left, Trigger] = ParseNumericFunction(Trigger);
    comma = strfind(Trigger, ',');
    [right, Trigger] = ParseNumericFunction(Trigger(comma+1:length(Trigger)));
    closeBracket = strfind(Trigger, ')');
    Trigger = Trigger(closeBracket+1:length(Trigger));

function [func, Trigger] = ParseNumericFunction(Trigger)
%fprintf(1,'In ParseNumericFunction parsing: %s\n', Trigger);
openBracket = strfind(Trigger, '(');
comma = strfind(Trigger, ',');
closeBracket = strfind(Trigger, ')');

if (isempty(openBracket) || (length(comma)~=0 && comma(1) < openBracket(1)) || (length(closeBracket)~=0 && closeBracket(1) < openBracket1))
    % simple case where no nesting 
    if (length(comma)~=0 && comma(1) < closeBracket(1))
        % terminated by comma
        func = Trigger(1:comma(1)-1);
        Trigger = Trigger(comma(1):length(Trigger));
    else
        if (length(closeBracket)~=0)
            % terminated by close bracket
            func = Trigger(1:closeBracket(1)-1);
            Trigger=Trigger(closeBracket(1):length(Trigger));
        else
            func=Trigger;
            Trigger='';
        end;
    end;
else
    % nested case
    Func = Trigger(1:OpenBracket-1);
    Trigger = Trigger(OpenBracket+1:length(Trigger));
    [subfunc, Trigger] = ParseNumericFunction(Trigger);
    Func = sprintf('%s(%s', Func, subfunc);
    Trigger = LoseLeadingWhiteSpace(Trigger);
    comma = strfind(Trigger, ',');
    
    while (length(comma) ~= 0 && comma(1) == 1)
        [subfunc, Trigger] = ParseNumericFunction(Trigger);
        Func = sprintf('%s,%s', Func, subfunc);
        Trigger = LoseLeadingWhiteSpace(Trigger);
        comma = strfind(Trigger, ',');
    end
    Func=sprintf('%s)',Func);
    closeBracket=strFind(Trigger, ')');
    Trigger = Trigger(closeBracket(1)+1:length(Trigger));
end;    
%fprintf(1,'at end of ParseNumericFunction function: %s\n', func);
%fprintf(1,'at end of ParseNumericFunction parsing: %s\n', Trigger);

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
