% toolbox\MATLAB_SBML_Structure_Functions\AlgebraicRule
%
%
% AlgebraicRule_create
%       takes 
%           1) an SBML level (optional)
%           2) an SBML version (optional)
%
%       and returns
%           an MATLAB_SBML AlgebraicRule structure of the appropriate
%           level and version
%
%    NOTE: the optional level and version preserve backwards compatability
%         if version is missing the default values will be L1V2; L2V4 or L3V1
%         if neither argument is supplied the default values will be L3V1
%
%
% AlgebraicRule_getFormula
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the value of the formula attribute
%
%
% AlgebraicRule_getMetaid
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the value of the metaid attribute
%
%
% AlgebraicRule_getSBOTerm
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the value of the sboTerm attribute
%
%
% AlgebraicRule_isSetFormula
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           1 if the value for the formula attribute is set
%           0 otherwise
%
%
% AlgebraicRule_isSetMetaid
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           1 if the value for the metaid attribute is set
%           0 otherwise
%
%
% AlgebraicRule_isSetSBOTerm
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           1 if the value for the sboTerm attribute is set
%           0 otherwise
%
%
% AlgebraicRule_setFormula
%       takes 
%           1) an SBML AlgebraicRule structure
%           2) char array representing the formula to be set
%
%       and returns
%           the AlgebraicRule with the new value for the formula attribute
%
%
% AlgebraicRule_setMetaid
%       takes 
%           1) an SBML AlgebraicRule structure
%           2) the metaid to be set
%
%       and returns
%           the AlgebraicRule with the new value for the metaid attribute
%
%
% AlgebraicRule_setSBOTerm
%       takes 
%           1) an SBML AlgebraicRule structure
%           2) an integer representing the sboTerm to be set
%
%       and returns
%           the AlgebraicRule with the new value for the sboTerm attribute
%
%
% AlgebraicRule_getFormula
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the AlgebraicRule with the value for the formula attribute unset
%
%
% AlgebraicRule_getMetaid
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the AlgebraicRule with the value for the metaid attribute unset
%
%
% AlgebraicRule_getSBOTerm
%       takes an SBML AlgebraicRule structure
%
%       and returns
%           the AlgebraicRule with the value for the sboTerm attribute unset
%


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


