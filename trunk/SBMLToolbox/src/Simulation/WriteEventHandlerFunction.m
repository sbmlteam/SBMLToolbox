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

% need to do something with this 
for i = 1:length(SBMLModel.event)
    fprintf(fileID, 'value = ~%s;\n', SBMLModel.event(i).trigger);
end;

fprintf(fileID, '\n%%stop integration\n');
fprintf(fileID, 'isterminal = 1;\n\n');

% this may depend on  model
fprintf(fileID, '%%set direction at which event should be looked for\n');
fprintf(fileID, 'direction = 0;\n\n');


fclose(fileID);

