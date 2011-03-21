function OutputAnalyticalSolution(varargin)
% OutputAnalyticalSolution takes 
%       1) a MATLAB_SBML model structure 
%       2) a flag to indicate whether to plot the output (optional)
%       3) time limit (optional)
%       4) number of time steps (optional)
%       5) a flag to indicate whther to output the simulation data as 
%           a comma separated variable (csv) file

%  Filename    :   OutputAnalyticalSolution.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: OutputODEFunction.m 8181 2008-09-18 17:43:37Z sarahkeating $
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
    error('OutputAnalyticalSolution(SBMLModel, ...)\n%s', 'must have at least one arguments');
elseif (nargin > 5)
    error('OutputAnalyticalSolution(SBMLModel, ...)\n%s', 'cannot have more than five arguments');
end;


SBMLModel = varargin{1};

% check first input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('OutputAnalyticalSolution(SBMLModel)\n%s', 'first argument must be an SBMLModel structure');
end;

soln = SolveAnalytically(SBMLModel);

if (~isstruct(soln))
  error('Error producing analytical solution');
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
    delta_t = 1;
    Number_points = length(Time_span);
end;

% check third argument
if ((length(Time_limit) ~= 1) || (~isnumeric(Time_limit)))
    error('OutputAnalyticalSolution(SBMLModel, time)\n%s', 'third argument must be a single real number indicating a time limit');
end;

plotOutput = 0;
if (nargin > 1)
  plotOutput = varargin{2};
end;

csvOutput = 0;
if (nargin > 4)
  csvOutput = varargin{5};
end;
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
fileName = strcat(Name, '.csv');

%--------------------------------------------------------------------

ff = fieldnames(soln);
number = length(ff);

index = 1;
finished = 1;
for i=0:delta_t:Time_limit
  TimeCourse(index) = i;  
  v = subs(soln.(ff{1}), 't', i);
  if (isnumeric(v))
    SpeciesCourse(1, index) = v;
  else
    disp(strcat(fileName, ' encountered a symbolic expression'));
    i=Time_limit;
    finished = 0;
    break;
  end;
  for j=2:number
    v = subs(soln.(ff{j}), 't', i);
    if (isnumeric(v))
      SpeciesCourse(j, index) = v;
    else
      disp('Encountered a symbolic expression');
      i=Time_limit;
      j=number;
      finished = 0;
      break;
    end;
  end;
  index = index + 1;
end;

Species = GetSpecies(SBMLModel);

%--------------------------------------------------------------
if (finished == 1 && plotOutput == 1)
    if (~(ismember(1, isnan(SpeciesCourse))))

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
                plot(TimeCourse,SpeciesCourse(i, :),Types{j});
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
%-------------------------------------------------------------------------
% write output file
% if simulation has failed do not
if (finished == 1 && csvOutput == 1)
    if (~(ismember(1, isnan(SpeciesCourse))))
        %------------------------------------------------------------

        % open the file for writing

        fileID = fopen(fileName, 'w');

        % write the header
        fprintf(fileID,  'time');
        for i = 1: length(Species)
            fprintf(fileID, ',%s', Species{i});
        end;
        fprintf(fileID, '\n');

        % write each time course step values
        for i = 1:length(TimeCourse)
            fprintf(fileID, '%0.5g', TimeCourse(i));

            for j = 1:length(Species)
                fprintf(fileID, ',%1.16g', SpeciesCourse(j, i));
            end;
            fprintf(fileID, '\n');

        end;

        fclose(fileID);


    end;
end;

