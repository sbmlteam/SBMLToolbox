% toolbox\MATLAB_SBML_Structure_Functions
%
%  GetLevelVersion 
%             takes an SBMLStructure
%             and returns 
%                1) the sbml level
%                2 the sbml version 
%
% This directory also contains functions that allow the user to
%               manipulate MATLAB_SBML structures.
%
% Each subfolder contains functions relating to that component of the model
%
%  e.g. toolbox\MATLAB_SBML_Structure_Functions\Compartment
%           contains functions of the form Compartment_getXXX etc 
%           that act on an SBMLCompartment structure
%
% The majority of functions mimic their equivalent with in the libSBML API
%
% Additional functions are highlighted in the help for the relevant
% directory.

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


