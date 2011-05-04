function [SBMLfieldnames, nNumberFields] = getRateRuleFieldnames(level, ...
                                                             version)

%
% getRateRuleFieldnames
%    takes an SBML level
%     and  an SBML version
%
%    returns
%      1) an array fieldnames for the RateRule structure of the appropriate
%                  level and version
%      2) the number of fieldnames expected

%  Filename    :   getRateRuleFieldnames.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: $
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


if (level == 1)
		SBMLfieldnames = [];
		nNumberFields = 0;
elseif (level == 2)
	if (version == 1)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'formula', ...
		                   'variable', ...
		                   'species', ...
		                   'compartment', ...
		                   'name', ...
		                   'units', ...
		                 };
		nNumberFields = 10;
	elseif (version == 2)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'sboTerm', ...
		                   'formula', ...
		                   'variable', ...
		                   'species', ...
		                   'compartment', ...
		                   'name', ...
		                   'units', ...
		                 };
		nNumberFields = 11;
	elseif (version == 3)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'sboTerm', ...
		                   'formula', ...
		                   'variable', ...
		                   'species', ...
		                   'compartment', ...
		                   'name', ...
		                   'units', ...
		                 };
		nNumberFields = 11;
	elseif (version == 4)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'sboTerm', ...
		                   'formula', ...
		                   'variable', ...
		                   'species', ...
		                   'compartment', ...
		                   'name', ...
		                   'units', ...
		                 };
		nNumberFields = 11;
	end;
elseif (level == 3)
	if (version == 1)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'sboTerm', ...
		                   'formula', ...
		                   'variable', ...
		                   'species', ...
		                   'compartment', ...
		                   'name', ...
		                   'units', ...
		                 };
		nNumberFields = 11;
	end;
end;
