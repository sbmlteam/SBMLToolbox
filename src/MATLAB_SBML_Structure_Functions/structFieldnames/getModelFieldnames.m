function [SBMLfieldnames, nNumberFields] = getModelFieldnames(level, ...
                                                              version)
% [fieldnames, num] = getModelFieldnames(level, version)
%
% Takes
%
% 1. level, an integer representing an SBML level
% 2. version, an integer representing an SBML version
%
% Returns
%
% 1. an array of fieldnames for an SBML Model structure of the given level and version
% 2. the number of fieldnames
%

%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright (C) 2009-2016 jointly by the following organizations: 
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










if (~isValidLevelVersionCombination(level, version))
  error ('invalid level/version combination');
end;

if (level == 1)
		SBMLfieldnames = { 'typecode', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'unitDefinition', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'rule', ...
		                   'reaction', ...
		                 };
		nNumberFields = 12;
elseif (level == 2)
	if (version == 1)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'id', ...
		                   'functionDefinition', ...
		                   'unitDefinition', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'rule', ...
		                   'reaction', ...
		                   'event', ...
		                 };
		nNumberFields = 16;
	elseif (version == 2)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'id', ...
		                   'sboTerm', ...
		                   'functionDefinition', ...
		                   'unitDefinition', ...
		                   'compartmentType', ...
		                   'speciesType', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'initialAssignment', ...
		                   'rule', ...
		                   'constraint', ...
		                   'reaction', ...
		                   'event', ...
		                 };
		nNumberFields = 21;
	elseif (version == 3)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'id', ...
		                   'sboTerm', ...
		                   'functionDefinition', ...
		                   'unitDefinition', ...
		                   'compartmentType', ...
		                   'speciesType', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'initialAssignment', ...
		                   'rule', ...
		                   'constraint', ...
		                   'reaction', ...
		                   'event', ...
		                 };
		nNumberFields = 21;
	elseif (version == 4)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'id', ...
		                   'sboTerm', ...
		                   'functionDefinition', ...
		                   'unitDefinition', ...
		                   'compartmentType', ...
		                   'speciesType', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'initialAssignment', ...
		                   'rule', ...
		                   'constraint', ...
		                   'reaction', ...
		                   'event', ...
		                 };
		nNumberFields = 21;
	end;
elseif (level == 3)
	if (version == 1)
		SBMLfieldnames = { 'typecode', ...
		                   'metaid', ...
		                   'notes', ...
		                   'annotation', ...
		                   'SBML_level', ...
		                   'SBML_version', ...
		                   'name', ...
		                   'id', ...
		                   'sboTerm', ...
		                   'functionDefinition', ...
		                   'unitDefinition', ...
		                   'compartment', ...
		                   'species', ...
		                   'parameter', ...
		                   'initialAssignment', ...
		                   'rule', ...
		                   'constraint', ...
		                   'reaction', ...
		                   'event', ...
		                   'substanceUnits', ...
		                   'timeUnits', ...
		                   'lengthUnits', ...
		                   'areaUnits', ...
		                   'volumeUnits', ...
		                   'extentUnits', ...
		                   'conversionFactor', ...
		                 };
		nNumberFields = 26;
	end;
end;
