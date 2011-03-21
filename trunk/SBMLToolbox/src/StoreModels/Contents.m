% toolbox\StoreModels
%
% This directory contains functions to save and load SBML models
%   from the data file SBML_Models.mat
%   and functions to browse the data file
%
%
% FUNCTIONS INCLUDE:
%
%   SaveSBMLModel(Model) 
%       checks that the structure supplied is of the correct form
%       creates "SBML_Models.mat" if the file does not already exist
%       write the model to the data file as the next element
%
%   LoadSBMLModel(input, level) 
%       returns a model from "SBML_Models.mat" where
%       input can be an integer relating to the number of the model within the data file
%       or the Name field of the model requested
%       and level is the SBML level (either 1 or 2)
%
%   ListSBMLModels 
%       returns a list of the saved models with index, level and names
%
%   DeleteSBMLModel(input, level) 
%       deletes a model from "SBML_Models.mat" where
%       input can be an integer relating to the number of the model within the data file
%       or the Name field of the model requested 
%       and level is the SBML level (either 1 or 2)
%
%   ViewModel(Model) 
%       raises a GUI that illustrate the SBML model 'Model'
%   NOT IMPLEMENTED BEYOND SBML LEVEL 2 VERSION 1
%
%   BrowseSBML_Models 
%       calls BrowseModels which enables a GUI that browses the MATLAB data file SBML_Models.dat
%       If an output argument is specified then a model can be loaded from the data file 
%       This GUI also allows models to be deleted from the data file 
%
%   BrowseModels(number) 
%       raises a GUI that browses the data file SBML_Models.dat
%       called from BrowseSBML_Models
%
%   AlreadyExists
%       raises a modal GUI that prompts user for overwrite permission for a
%       model name that already exists within the SBML_Models data file

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

