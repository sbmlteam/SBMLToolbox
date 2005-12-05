function varargout = PlotSelectedTimeCourse(varargin)
% PlotSelectedTimeCourse takes
%       1) an SBMLModel
%       2) time limit (optional)
%       3) number of time steps (optional)
%
% and plots the time course of user selected species to equilibrium
% 
%and returns
%       1) the value of each species at the time limit (optional)

%--------------------------------------------------------------------------

%
%  Filename    : PlotSelectedTimeCourse.m
%  Description : takes a SBMLModel and optionally a time limit
%                   and plots the timecourse of user selected species to the time limit (or equilibrium)
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

% must be at least one input
if (nargin < 1)
    error('PlotSelectedTimeCourse(SBMLModel, ...)\n%s', 'must have at least one input');
elseif (nargin > 3)
    error('PlotSelectedTimeCourse(SBMLModel, ...)\n%s', 'cannot have more than three inputs');   
end;

% assign inputs 
SBMLModel = varargin{1};
    
% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('PlotSelectedTimeCourse(SBMLModel, ...)\n%s', 'first input must be an SBMLModel structure');
end;

%------------------------------------------------------------
% look for rules/functions and warn user that these are not dealt with yet
Rules = length(SBMLModel.rule);
if (SBMLModel.SBML_level == 2)
    Funcs = length(SBMLModel.functionDefinition);
else
    Funcs = 0;
end;

if ((Rules ~= 0) || (Funcs ~= 0))
    disp('Note this procedure does not yet deal with rules or functions');
    disp('They will NOT be included in the calculation');
end;

%------------------------------------------------------------

% get the symbolic form of the species, the corresponding rate laws
% and any parameters
[Species, Rates] = GetSymbolicRateLawsFromReactions(SBMLModel);

[Parameters] = GetAllParameterSymbolsUnique(SBMLModel);

%------------------------------------------------------------

% get the character strings for each species name
[x, y, Speciesnames] = GetSpeciesSymbols(SBMLModel);

%------------------------------------------------------------

%check that values for the parameters 
% and initial species concentrations are sensible
[SpeciesValues, ParameterValues] = CheckValues(SBMLModel);

%-----------------------------------------------------------------------
% declare symbolic variable for time - t
% integrate the rate equations wrt t
syms t;
IntRate = int(Rates, t);

% since d[SpeciesConc]/dt = rate
% d[SpeciesConc] = integral(rate)
% [new species conc] = [old species conc] + integral(rate)
% symbolically this becomes
NewSpecies = Species + IntRate;

%-----------------------------------------------------------------------
% calculate values to use in iterative process
if (nargin > 1)
    Time_limit = varargin{2};
else
    Time_limit = abs((1/max(ParameterValues))*60);
end;

if (nargin > 2)
    delta_t = Time_limit/varargin{3};
else
    delta_t = abs((1/max(ParameterValues))/10);
end;

% substitute fixed values into the NewSpecies symbolic form
NewSpecies = subs(NewSpecies, Parameters, ParameterValues);
NewSpecies = subs(NewSpecies, t, delta_t);

%-----------------------------------------------------------------------

% assign initial values
Time = 0;
counter = 1;
TimeCourse(counter) = Time;
for i = 1:length(Species)
    SpeciesCourse{i}(counter) = SpeciesValues(i);
end;

% assign first step
Time = Time + delta_t;
counter = counter + 1;
OldValues = subs(NewSpecies, Species, SpeciesValues);
TimeCourse(counter) = Time;
for i = 1:length(Species)
    SpeciesCourse{i}(counter) = OldValues(i);
end;

%-----------------------------------------------------------------------
% iterate to required tolerance 
while (Time < Time_limit)
    % calculate new values
    Time = Time + delta_t;
    counter = counter + 1;
    NewValues = subs(NewSpecies, Species, OldValues);
    
    % record values
    TimeCourse(counter) = Time;
    for i = 1:length(Species)
        SpeciesCourse{i}(counter) = NewValues(i);
    end;
   
    % check for negative concentration values
    negcheck = NewValues < 0;
    if (ismember(1, negcheck))
        disp('Negative concentration in PlotTimeCourse');
        disp('Function terminated');
        NewValues = OldValues;
        break;
    end;
   
    % assign values
    OldValues = NewValues;
end;

%-----------------------------------------------------------------------
% plot the time course for each species
PlotSpecies = SelectSpecies(SBMLModel);

% line styles - will look at these
Types = {'-oc', '-om', '-oy', '-ok', '-or', '-og', '-ob', '--c', '--m', '--y', '--k', '--r', '--g', '--b'};
j = 1;

plotcount = 1;
axis([0, TimeCourse(counter), -Inf, Inf]);
for i = 1:length(Species)
    % check whether to plot
    Plot = 0;
    for k = 1:length(PlotSpecies)
        if (strcmp(PlotSpecies{k}, Speciesnames{i}))
            Plot = 1;
        end;
    end;
    
    if (Plot == 1)
        
        if (j > 14)
            j = 1;
        end;
        plot(TimeCourse, SpeciesCourse{i}, Types{j});
        hold on;
        j = j + 1;
        PlottedSpecies{plotcount} = Speciesnames{i};
        plotcount = plotcount + 1;
    end;
    
end;
hold off;
    ylabel('Amount');
    xlabel('Time t');
legend(PlottedSpecies, -1);

%-------------------------------------------------------------------------
% assign output
for i = 1:length(Species)
    Concs(i) = SpeciesCourse{i}(counter);
end;
varargout{1} = Concs;