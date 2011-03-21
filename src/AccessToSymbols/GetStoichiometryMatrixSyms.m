function varargout = GetStoichiometryMatrixSyms(SBMLModel)
% GetStoichiometryMatrixSyms(SBMLModel) takes an SBML model 
% and returns 
%           1) stoichiometry matrix
%           2) array of symbols respresenting each species in same order
%               as the stoichiometry matrix treats them
%--------------------------------------------------------------------------

%  Filename    : GetStoichiometryMatrixSyms.m
%  Description : takes an SBML model and returns the stoichiometry matrix
%                   and an array of the symbolic represntation of the
%                   species
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



varargout{1} = GetStoichiometryMatrix(SBMLModel);
varargout{2} = GetSpeciesSymbols(SBMLModel);
