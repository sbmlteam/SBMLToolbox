% toolbox\Simulation
%
% This directory contains functions to simulate an SBML model
%
%
% FUNCTIONS INCLUDE:
%   AnalyseSpecies  
%       takes a matlab sbml model structure and outputs a
%       structure detailing the species and how they are manipulated within the
%       model
%
%   DealWithPiecewise              
%       takes a string representation of a formula that contains the MathML
%       piecewise function and returns an array of the three components of the 
%       piecewise function which can then be written as an if else statement
% 
%   DisplayODEFunction             
%       takes a matlab sbml model structure and a number of optional arguments 
%       and can plot the results of the ode45 solver (ode15s if stiff) and output
%       a comma seperated variable (CSV) file of the simulation results
%
%   GetArgumentsFromLambdaFunction 
%       takes a string representation of a formula that contains the MathML lambda function 
%       and returns an array of the components of the lambda function
%       which can then be used to substitute arguments where the function has been applied
%
%   SelectSpecies                  
%       takes an SBML Model, displays a GUI that allows the user to add/remove species from a list
%       and returns an array of Species selected by the user
%
%   WriteEventAssignmentFunction   
%       takes a matlab sbml model structure and outputs a file defining a function 
%       that assigns values following an event (for use with the event option in matlabs ode solvers)
%
%   WriteEventHandlerFunction      
%       takes a matlab sbml model structure and outputs a file defining a function 
%       that handles an event (for use with the event option in matlabs ode solvers)
%
%   WriteODEFunction               
%       takes a matlab sbml model structure and outputs a file defining a function 
%       for use with matlabs ode solvers


%  Filename    :   Contents.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   12-Feb-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
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
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):



