function OutputODEFunction(varargin)
% OutputODEFunction takes 
%       1) a MATLAB_SBML model structure 
%       2) a flag to indicate whether to plot the output (optional)
%       3) time limit (optional)
%       4) number of time steps (optional)
%       5) a flag to indicate whther to output the simulation data as 
%           a comma separated variable (csv) file
%       6) a filename
%       7) a flag to indicate whether to output species values in amount/concentration
%           1 amount, 0 concentration (default)
%          
%  and plots the results of the ode45 solver 
%
% NOTE: a filename is required when WriteODEFunction has been
%       called with a filename

%  Filename    :   OutputODEFunction.m
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
    error('OutputODEFunction(SBMLModel, ...)\n%s', 'must have at least one argument');
elseif (nargin > 7)
    error('OutputODEFunction(SBMLModel, ...)\n%s', 'cannot have more than seven arguments');
end;


SBMLModel = varargin{1};

% check first input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('OutputODEFunction(SBMLModel)\n%s', 'first argument must be an SBMLModel structure');
end;
%------------------------------------------------------------
% calculate values to use in iterative process
if (nargin > 2)
    Time_limit = varargin{3};
else
    Time_limit = 10;
end;

if (nargin > 3)
    delta_t = Time_limit/varargin{4};
    Time_span = [0:delta_t:Time_limit];
    Number_points = length(Time_span);
else
    Time_span = [0, Time_limit];
end;

outAmt = 0;
if (nargin > 6)
  if (varargin{7} == 1)
    outAmt = 1;
  end;
end;
% check third argument
if ((length(Time_limit) ~= 1) || (~isnumeric(Time_limit)))
    error('OutputODEFunction(SBMLModel, time)\n%s', 'third argument must be a single real number indicating a time limit');
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

if (length(Name) > 63)
    Name = Name(1:60);
end;

fileName = strcat(Name, '.m');

%--------------------------------------------------------------
% check that a .m file of this name exists
% check whether file exists
fId = fopen(fileName);
if (fId == -1)
    if (nargin > 5)
        Name = varargin{6};
        fileName = strcat(Name, '.m');
        fId = fopen(fileName);
        if (fId == -1)
            error('OutputODEFunction(SBMLModel)\n%s', 'You have not used this filename with WriteODEFunction');
        else
            fclose(fId);
        end;
    else
        error('OutputODEFunction(SBMLModel)\n%s\n%s', 'You must use WriteODEFunction to output an ode function for this model', 'before using this function');
    end;
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

        [TimeCourseA, SpeciesCourseA, eventTime, ab, eventNo] = ode45(fhandle, Time_span, InitConds, options);

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


        [len, wid] = size(SpeciesCourseA);
        for i = 1:length(SBMLModel.species)
            SpeciesValues(i) = SpeciesCourseA(len, i);
        end;

        if (TimeCourseA(end) ~= Time_span(end))

            TimeCourseA = TimeCourseA(1:length(TimeCourseA)-1);
            for i = 1:length(SBMLModel.species)
                SpeciesCourseB(:,i) = SpeciesCourseA(1:len-1, i);
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
            SpeciesValues = feval(AfterEventHandle, eventTime, SpeciesValues, eventNo);
            [t,NewValues, eventTime, ab, eventNo] = ode45(fhandle, [eventTime, Time_span(1)], SpeciesValues, options);
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
%     % if no events
%   if exist('OCTAVE_VERSION')
%     SpeciesCourse = lsode(fhandle, InitConds, Time_span);
%     TimeCourse = Time_span;
%   else
    [TimeCourse, SpeciesCourse] = ode45(fhandle, Time_span, InitConds, options);
%   end;
end;

%check whether solution is feasible and if not use a stiff equation solver
fail = 0;
if exist('OCTAVE_VERSION')
  fail = testmember(1, isnan(SpeciesCourse));
else
  fail = ismember(1, isnan(SpeciesCourse));
end;

if (fail && ~exist('OCTAVE_VERSION'))
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
% dont even try and plot from octave
if (~exist('OCTAVE_VERSION'))

if ((nargin > 1) && (varargin{2} == 1))
  fail = 0;
  if exist('OCTAVE_VERSION')
    fail = testmember(1, isnan(SpeciesCourse));
  else
    fail = ismember(1, isnan(SpeciesCourse));
  end;

    if (~fail)

        PlotSpecies = SelectSpecies(SBMLModel);

        % line styles - will look at these
        Types = {'-oc', '-om', '-oy', '-ok', '-or', '-og', '-ob', '--c', '--m', '--y', '--k', '--r', '--g', '--b'};
        j = 1;

        %plot the output
        plotCount = 1;
        for i = 1:length(Species)
            % check whether to plot
            Plot = 0;
            for k = 1:length(PlotSpecies)
                if (strcmp(PlotSpecies{k}, Species{i}))
                    Plot = 1;
                end;
            end;

            if (Plot == 1)
                if (j > 14)
                    j = 1;
                end;
                plot(TimeCourse,SpeciesCourse(:,i),Types{j});
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
end;

end;
%-------------------------------------------------------------------------
% write output file
% if simulation has failed do not
fail = 0;
if exist('OCTAVE_VERSION')
  fail = testmember(1, isnan(SpeciesCourse));
else
  fail = ismember(1, isnan(SpeciesCourse));
end;

if (~fail)
     if ((nargin > 4) && (varargin{5} == 1))
        %------------------------------------------------------------
        % get the character strings for each species name
         [Speciesnames] = GetSpecies(SBMLModel);

        %---------------------------------------------------------------
        fileName = strcat(Name, '.csv');
      
        %--------------------------------------------------------------------
        % open the file for writing

        fileID = fopen(fileName, 'w');

        % write the header
        fprintf(fileID,  'time');
        for i = 1: length(Species)
            fprintf(fileID, ',%s', Speciesnames{i});
        end;
        fprintf(fileID, '\n');

        % write each time course step values
        for i = 1:length(TimeCourse)
            fprintf(fileID, '%0.5g', TimeCourse(i));

            for j = 1:length(Species)
              if (outAmt == 1)
                % not necessarily the size given
                [compartments, comp_values] = GetCompartments(SBMLModel);
                if (length(compartments) == 1)
                  comp_size = comp_values(1);
                else
                  % need to deal with mutliple compartments
                  comp = Model_getCompartmentById(SBMLModel, SBMLModel.species(j).compartment);
                  com_size = comp.size;
                end;
                % catch any anomalies
                if (isnan(comp_size))
                  comp_size = 1;
                end;
                fprintf(fileID, ',%1.16g', SpeciesCourse(i,j)*comp_size);
              else
                fprintf(fileID, ',%1.16g', SpeciesCourse(i,j));
              end;
            end;
            fprintf(fileID, '\n');

        end;

        fclose(fileID);


     end;
 end;














