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
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2011 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. EMBL European Bioinformatics Institute (EBML-EBI), Hinxton, UK
%
% Copyright (C) 2006-2008 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA
%     2. University of Hertfordshire, Hatfield, UK
%
% Copyright (C) 2003-2005 jointly by the following organizations: 
%     1. California Institute of Technology, Pasadena, CA, USA 
%     2. Japan Science and Technology Agency, Japan
%     3. University of Hertfordshire, Hatfield, UK
%
% SBMLToolbox is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
%----------------------------------------------------------------------- -->

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

[Compartments, CompartmentValues] = GetCompartmentSymbols(SBMLModel);
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
NewSpecies = subs(NewSpecies, Compartments, CompartmentValues);
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
