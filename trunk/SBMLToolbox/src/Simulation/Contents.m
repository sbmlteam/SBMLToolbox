% toolbox\Simulation
%
% This directory contains functions to simulate an SBML model
%
%   AnalyseSpecies  
%       takes an SBMLModel
%       and returns
%           structure detailing the species and 
%               how they are manipulated within the model
%
%   DealWithPiecewise              
%       takes a string representation of a formula that contains the MathML
%               piecewise function 
%       and returns 
%           an array of the three components of the piecewise function 
% 
%   DisplayODEFunction             
%       takes an SBMLModel and a number of optional arguments 
%       and plots the results of the ode45 solver 
%
%   GetArgumentsFromLambdaFunction 
%       takes a string representation of a formula that contains the MathML 
%               lambda function 
%       and returns 
%           an array of the components of the lambda function
%
%   OutputODEFunction             
%       takes an SBMLModel and a number of optional arguments 
%       and according to flags 
%       plots the results of the ode45 solver/outputs the data as a csv file 
%
%   SelectSpecies                  
%       takes an SBML Model, 
%       displays a GUI that allows the user to add/remove species from a list
%       and returns 
%           an array of species selected by the user
%
%   WriteEventAssignmentFunction   
%       takes an SBMLModel
%       and outputs 
%           a file defining a function that assigns values following an event
%
%   WriteEventHandlerFunction      
%       takes an SBMLModel
%       and outputs 
%           a file defining a function that handles an event 
%
%   WriteODEFunction               
%       takes an SBMLModel and anoptional arguments 
%       and outputs 
%           a file defining a function for use with MATLABs ode solvers

%  Filename    :   Contents.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->




