function DisplayODEFunction(varargin)
%
%  Filename    : DisplayODEFunction.m
%  Description : takes a SBMLModel and plots teh output from matlabs ode solvers
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
%  and plots the results of the ode23 solver 


% get inputs
if (nargin < 1)
    error('DisplayODEFunction(SBMLModel, ...)\n%s', 'must have at least one argument');
elseif (nargin > 2)
    error('DisplayODEFunction(SBMLModel, ...)\n%s', 'cannot have more than two arguments');
end;


SBMLModel = varargin{1};
if (nargin == 2)
    t_end = varargin{2};
else
    t_end = 10;
end;
   

% check first input is an SBML model
if (~isSBML_Model(SBMLModel))
    error('DisplayODEFunction(SBMLModel)\n%s', 'first argument must be an SBMLModel structure');
end;

% check second argument
if ((length(t_end) ~= 1) || (~isnumeric(t_end)))
    error('DisplayODEFunction(SBMLModel, time)\n%s', 'second argument must be a single real number');
end;

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

% solve 
[t, x] = ode23(fhandle, [0,t_end], InitConds);
%--------------------------------------------------------------

Species = GetSpecies(SBMLModel);

% line styles - will look at these
Types = {'-oc', '-om', '-oy', '-ok', '-or', '-og', '-ob', '--c', '--m', '--y', '--k', '--r', '--g', '--b'};
j = 1;

%plot the output
for i = 1:length(Species)
    if j > 14
        j = 1;
    end;
    plot(t,x(:,i),Types{j});
    hold on;
    j = j+1;
end;
hold off;
xlabel('time t');
ylabel('amount');
legend(Species, -1);








