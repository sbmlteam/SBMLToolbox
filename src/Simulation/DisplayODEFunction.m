function DisplayODEFunction(varargin)
% DisplayODEFunction takes 
%       1) a matlab sbml model structure 
%       2) time limit (optional)
%       3) number of time steps (optional)
%       4) a filename (optional)
%          
%  and plots the results of the ode45 solver 
%
% NOTE: a filename is required when WriteODEFunction has been
%       called with a filename

%
%  Filename    : DisplayODEFunction.m
%  Description : takes a SBMLModel and plots the output from matlabs ode solvers
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
% DisplayODEFunction takes 
%       1) a matlab sbml model structure 
%       2) time limit (optional)
%  and plots the results of the ode45 solver 


% get inputs
if (nargin < 1)
    error('DisplayODEFunction(SBMLModel, ...)\n%s', 'must have at least one argument');
elseif (nargin > 4)
    error('DisplayODEFunction(SBMLModel, ...)\n%s', 'cannot have more than four arguments');
end;


SBMLModel = varargin{1};

% check first input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('DisplayODEFunction(SBMLModel)\n%s', 'first argument must be an SBMLModel structure');
end;

%------------------------------------------------------------
% calculate values to use in iterative process
if (nargin > 1)
    Time_limit = varargin{2};
else
    Time_limit = 10;
end;

if (nargin > 2)
    delta_t = Time_limit/varargin{3};
    Time_span = [0:delta_t:Time_limit];
    Number_points = length(Time_span);
else
    Time_span = [0, Time_limit];
end;

% check second argument
if ((length(Time_limit) ~= 1) || (~isnumeric(Time_limit)))
    error('DisplayODEFunction(SBMLModel, time)\n%s', 'third argument must be a single real number indicating a time limit');
end;

filename = '';
if (nargin > 3)
    filename = varargin{4};
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

%--------------------------------------------------------------
% check that a .m file of this name exists
% check whether file exists
fId = fopen(fileName);
if (fId == -1)
    error('DisplayODEFunction(SBMLModel)\n%s\n%s', 'You must use WriteODEFunction to output an ode function for this model', 'before using this function');
else
    fclose(fId);
end;

%---------------------------------------------------------------
% get function handle

fhandle = str2func(Name);

% get initial conditions
InitConds = feval(fhandle);
 % set the tolerances of the odesolver to appropriate values
RelTol = min(InitConds(find(InitConds~= 0))) * 1e-4;
if (RelTol > 1e-6)
    RelTol = 1e-6;
end;
AbsTol = RelTol * 1e-4;

options = odeset('RelTol', RelTol, 'AbsTol', AbsTol);
% if there are events
if ((SBMLModel.SBML_level == 2) && (length(SBMLModel.event) ~= 0))
    eventName = strcat(Name, '_events');
    afterEvent = strcat(Name, '_eventAssign');
    eventHandle = str2func(eventName);
    AfterEventHandle = str2func(afterEvent);

    % solve - need to deal with events here
    options = odeset('Events', eventHandle, 'RelTol', RelTol, 'AbsTol', AbsTol);

    TimeCourse = [];
    SpeciesCourse = [];

    while ((~isempty(Time_span)) && (Time_span(1) < Time_span(end)))

        [TimeCourseA, SpeciesCourseA] = ode45(fhandle, Time_span, InitConds, options);

        % need to catch case where the time span entered was two sequential
        % times from the original time-span
        % e.g. original Time_span = [0, 0.1, ..., 4.9, 5.0]
        % Time_span = [4.9, 5.0]
        %
        % ode solver will output points between
        if (length(Time_span) == 2)
            NewTimeCourse = [TimeCourseA(1); TimeCourseA(end)];
            TimeCourseA = NewTimeCourse;
            for i = 1:length(SBMLModel.species)
                NewSpecies(1,i) = SpeciesCourseA(1, i);
                NewSpecies(2,i) = SpeciesCourseA(end, i);
            end;
            SpeciesCourseA = NewSpecies;

        end;

        % keep copy of event time
        eventTime = TimeCourseA(end);
        for i = 1:length(SBMLModel.species)
            SpeciesValues(i) = SpeciesCourseA(length(SpeciesCourseA), i);
        end;

        if (TimeCourseA(end) ~= Time_span(end))

            TimeCourseA = TimeCourseA(1:length(TimeCourseA)-1);
            for i = 1:length(SBMLModel.species)
                SpeciesCourseB(:,i) = SpeciesCourseA(1:length(SpeciesCourseA)-1, i);
            end;
        else
            SpeciesCourseB = SpeciesCourseA;
        end;
        % adjust the time span
        Time_spanA = Time_span - TimeCourseA(length(TimeCourseA));
        Time_span_new = Time_spanA((find(Time_spanA==0)+1): length(Time_spanA));
        Time_span = [];
        Time_span = Time_span_new + TimeCourseA(length(TimeCourseA));

        % get new initial conditions
        if (~isempty(Time_span))
            SpeciesValues = feval(AfterEventHandle, eventTime, SpeciesValues);
            [t,NewValues] = ode45(fhandle, [eventTime, Time_span(1)], SpeciesValues, options);
            for i = 1:length(SBMLModel.species)
                InitConds(i) = NewValues(length(NewValues), i);
            end;
        end;

        % keep copy of calculations
        TimeCourse = [TimeCourse;TimeCourseA];
        SpeciesCourse = [SpeciesCourse;SpeciesCourseB];

        TimeCourseA = [];
        SpeciesCourseA = [];
        SpeciesCourseB = [];
    end;
else
    % if no events
    [TimeCourse, SpeciesCourse] = ode45(fhandle, Time_span, InitConds, options);
end;

%check whether solution is feasible and if not use a stiff equation solver
if (ismember(1, isnan(SpeciesCourse)))
    disp('Equations appear to be stiff - solution being recalculated with ode23s/n');
    if (nargin > 3)
        delta_t = Time_limit/varargin{4};
        Time_span = [0:delta_t:Time_limit];
        Number_points = length(Time_span);
    else
        Time_span = [0, Time_limit];
    end;

    TimeCourse = [];
    SpeciesCourse = [];
    % if there are events
    if ((SBMLModel.SBML_level == 2) && (length(SBMLModel.event) ~= 0))
        while ((~isempty(Time_span)) && (Time_span(1) < Time_span(end)))

            [TimeCourseA, SpeciesCourseA] = ode23s(fhandle, Time_span, InitConds, options);

            % need to catch case where the time span entered was two sequential
            % times from the original time-span
            % e.g. original Time_span = [0, 0.1, ..., 4.9, 5.0]
            % Time_span = [4.9, 5.0]
            %
            % ode solver will output points between
            if (length(Time_span) == 2)
                NewTimeCourse = [TimeCourseA(1); TimeCourseA(end)];
                TimeCourseA = NewTimeCourse;
                for i = 1:length(SBMLModel.species)
                    NewSpecies(1,i) = SpeciesCourseA(1, i);
                    NewSpecies(2,i) = SpeciesCourseA(end, i);
                end;
                SpeciesCourseA = NewSpecies;

            end;

            % keep copy of event time
            eventTime = TimeCourseA(end);
            for i = 1:length(SBMLModel.species)
                SpeciesValues(i) = SpeciesCourseA(length(SpeciesCourseA), i);
            end;

            if (TimeCourseA(end) ~= Time_span(end))

                TimeCourseA = TimeCourseA(1:length(TimeCourseA)-1);
                for i = 1:length(SBMLModel.species)
                    SpeciesCourseB(:,i) = SpeciesCourseA(1:length(SpeciesCourseA)-1, i);
                end;
            else
                SpeciesCourseB = SpeciesCourseA;
            end;
            % adjust the time span
            Time_spanA = Time_span - TimeCourseA(length(TimeCourseA));
            Time_span_new = Time_spanA((find(Time_spanA==0)+1): length(Time_spanA));
            Time_span = [];
            Time_span = Time_span_new + TimeCourseA(length(TimeCourseA));

            % get new initial conditions
            if (~isempty(Time_span))
                SpeciesValues = feval(AfterEventHandle, eventTime, SpeciesValues);
                [t,NewValues] = ode23s(fhandle, [eventTime, Time_span(1)], SpeciesValues, options);
                for i = 1:length(SBMLModel.species)
                    InitConds(i) = NewValues(length(NewValues), i);
                end;
            end;

            % keep copy of calculations
            TimeCourse = [TimeCourse;TimeCourseA];
            SpeciesCourse = [SpeciesCourse;SpeciesCourseB];

            TimeCourseA = [];
            SpeciesCourseA = [];
            SpeciesCourseB = [];
        end;
    else
        % if no events
        [TimeCourse, SpeciesCourse] = ode23s(fhandle, Time_span, InitConds, options);
    end;

end;

Species = GetSpecies(SBMLModel);

%--------------------------------------------------------------
if (~(ismember(1, isnan(SpeciesCourse))))

    PlotSpecies = SelectSpecies(SBMLModel);

    % line styles - will look at these
    Types = {'-oc', '-om', '-oy', '-ok', '-or', '-og', '-ob', '--c', '--m', '--y', '--k', '--r', '--g', '--b'};
    j = 1;

    %plot the output
    plotCount = 1;
    Plot = 0;
    for i = 1:length(Species)
        % check whether to plot
        Plot_this = 0;
        for k = 1:length(PlotSpecies)
            if (strcmp(PlotSpecies{k}, Species{i}))
                Plot_this = 1;
            end;
        end;

        if (Plot_this == 1)
            if (j > 14)
                j = 1;
            end;
            plot(TimeCourse,SpeciesCourse(:,i),Types{j});
            Plot = 1;
            hold on;
            j = j+1;
            PlottedSpecies{plotCount} = Species{i};
            plotCount = plotCount + 1;
        end;
    end;
    if (Plot ~= 0)
        hold off;
        xlabel('time t');
        ylabel('amount');
        legend(PlottedSpecies, -1);
    end;
end;












