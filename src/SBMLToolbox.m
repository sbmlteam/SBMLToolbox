% SBMLToolbox
%
% SBMLToolbox is an open-source MATLAB toolbox that provides a MATLAB user 
% with functions for reading, writing and manipulation data expressed 
% in the Systems Biology Markup Language (SBML).
% 
% It works on Windows, Linux, and MacOS systems. 
% 
% The SBMLToolbox supports reading and writing of SBML Level 1 (Versions 1 and 2) and Level 2 and 
% the simulation of all aspects of an SBML model.
%
%
% FUNCTIONS include:
%
% toolbox
%
%  BuildTranslate_Win32 
%		which builds the TranslateSBML executable
%  TranslateSBML 
%		which translates a sbml file into a matlab structure
%  BuildOutput_Win32 
%		which builds the TranslateSBML executable
%  OutputSBML('SBML_MATLAB structure') 
%		which translates a sbml-matlab structure and ouputs an sbml file
%
% toolbox\AccessModel
%
%       This directory contains functions that allow the user to
%       derive information from a SBML Model
%
% toolbox\AccessToSymbols
%
%       This directory provides functions that allow access to the Symbolic Math Toolbox
%
% toolbox\Convenience
%
%       This directory contains functions useful to the simulation of an SBML model
%
% toolbox\MATLAB_SBML_Structure_Functions
%
%       This directory contains functions that allow the user to
%       manipulate a MATLAB_SBML Model structure
%
%       The majority of functions mimic their equivalent with in the libSBML API
%       with additional functions highlighted in the help for the relevant
%       directory
%
% toolbox\Simulation
%
%       This directory contains functions to simulate an SBML model
%
% toolbox\StoreModels
%
%       This directory contains functions to save and load SBML models
%       from the data file SBML_Models.mat
%       and functions to browse the data file
%
% toolbox\Validate_MATLAB_SBML_Structures
% 
%       This directory contains functions to validate the MATLAB_SBML
%       structures
%
% toolbox\ViewModelComponents
%
%       This directory contains functions to drive GUIs to view MATLAB_SBML structures





%
%  Description : This is the top level directory for the functions to translate 
%				 sbml models into a MATLAB structure which can then be saved.
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
%
%
