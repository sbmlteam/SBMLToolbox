function [EquilValues, EquilCond] = GetEquilibrium(SBMLModel)
% GetEquilibrium takes an SBMLModel 
% and returns 
%           1) an array representing the equilibrium values of each species 
%           2) a structure containing other equilibrium conditions
%                 species       - symbolic array of species
%                 initialValues - initial values for each species
%                 equilValues   - equilibrium values ( = 0 if not reached)
%                 timeValues    - values at time limit
%                 Time          - time taken to reach equilibrium
%                 delta_t       - time step used
%                 tolerance     - tolerance achieved
%
%--------------------------------------------------------------------------

%
%  Filename    : GetEquilibrium.m
%  Description : takes a SBMLModel and returns the value of the species at
%                   equilibrium and a structure containing information relating to the
%                   equilibrium
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

% check input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('GetEquilibrium(SBMLModel)\n%s', 'input must be an SBMLModel structure');
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

% calculate values to use in iterative process
delta_t = abs((1/max(ParameterValues))/10);
Time_limit = abs((1/max(ParameterValues))*60);
tolerance = abs(0.000001 * max(SpeciesValues));

% substitute fixed values into the NewSpecies symbolic form
NewSpecies = subs(NewSpecies, Parameters, ParameterValues);
NewSpecies = subs(NewSpecies, t, delta_t);

% assign initial values
Time = 0;
OldValues = subs(NewSpecies, Species, SpeciesValues);

% iterate concentrations to required tolerance 
while (Time < Time_limit)
    % calculate new values
    Time = Time + delta_t;
    NewValues = subs(NewSpecies, Species, OldValues);
    
    % check for negative concentration values
    negcheck = NewValues < 0;
    if (ismember(1, negcheck))
        disp('Negative concentration in GetEquilibrium');
        disp('Function terminated');
        NewValues = OldValues;
        break;
    end;
    
    % check whether the required tolerance has been achieved
    check = abs(NewValues-OldValues) < tolerance;
    if (sum(check) == length(SpeciesValues))
        break;
    end;

    
    % assign values
    OldValues = NewValues;
end;

% once here either the required tolerance has been achieved
% or the time limit has been exceeded

if (Time >= Time_limit)
    disp('Equilibrium not achieved');
    EquilValues = 0;
else
    EquilValues = NewValues;
end;

% -------------------------------------------------------------------
% assign outputs
EquilCond.species = Species;
EquilCond.initialValues = SpeciesValues;
EquilCond.equilValues = EquilValues;
EquilCond.timeValues = NewValues;
EquilCond.Time = Time;
EquilCond.delta_t = delta_t;
EquilCond.tolerance = tolerance;
