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
%       calls BrowseModels which enables a GUI that browses the Matlab data file SBML_Models.dat
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


%
%  Description : This is the directory for the functions  
%				 to save sbml models in MATLAB 
%  Author(s)   : SBML Development Group <sbml-team@caltech.edu>
%  Organization: University of Hertfordshire STRC
%  Created     : 2003-09-15
%  Revision    : $Id$
%  Source      : $Source$
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
