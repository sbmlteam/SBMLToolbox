function DisplayODEFunction(varargin)
% DisplayODEFunction takes 
%       1) a MATLAB_SBML model structure 
%       2) time limit (optional)
%       3) number of time steps (optional)
%       4) a filename (optional)
%          
%  and plots the results of the ode45 solver 
%
% NOTE: a filename is required when WriteODEFunction has been
%       called with a filename

%  Filename    :   DisplayODEFunction.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
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
            SpeciesValues(i) = SpeciesCourseA(2, i);
        end;

        if (TimeCourseA(end) ~= Time_span(end))

            TimeCourseA = TimeCourseA(1:length(TimeCourseA)-1);
            for i = 1:length(SBMLModel.species)
                SpeciesCourseB(:,i) = SpeciesCourseA(1:1, i);
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
    disp('Equations appear to be stiff - solution being recalculated with ode23s');
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
    Types = {'-c', '-m', '-y', '-k', '-r', '-g', '-b', '--c', '--m', '--y', '--k', '--r', '--g', '--b'};
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
else
    disp('Simulation failed');
end;












