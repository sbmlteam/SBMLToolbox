function [EquilValues, EquilCond] = GetEquilibrium(SBMLModel)
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
% GetEquilibrium takes a SBMLModel 
% and returns 
%           1) an array representing the equilibrium values of each species 
%           2) a structure containing other equilibrium conditions
%                 species - symbolic array of species
%                 initialValues - initial values for each species
%                 equilValues - equilibrium values ( = 0 if not reached)
%                 timeValues - values at time limit
%                 Time - time taken to reach equilibrium
%                 delta_t - time step used
%                 tolerance - tolerance achieved
%                 Time_limit - the time limit on the iterative process
%
%--------------------------------------------------------------------------

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
[Species, Rates] = GetSpeciesRateLaws(SBMLModel);

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
EquilCond.Time_limit = Time_limit;
