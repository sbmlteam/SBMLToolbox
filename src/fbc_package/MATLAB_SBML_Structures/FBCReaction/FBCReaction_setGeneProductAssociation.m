function SBMLFBCReaction = FBCReaction_setGeneProductAssociation(SBMLFBCReaction, geneProductAssociation)
% SBMLFBCReaction = FBCReaction_setGeneProductAssociation(SBMLFBCReaction, geneProductAssociation)
%
% Takes
%
% 1. SBMLFBCReaction, an SBML FBCReaction structure
% 2. geneProductAssociation, a number representing the fbc_geneProductAssociation to be set
%
% Returns
%
% 1. the SBML FBC FBCReaction structure with the new value for the fbc_geneProductAssociation attribute
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


%get level and version and check the input arguments are appropriate

[level, version] = GetLevelVersion(SBMLFBCReaction);

if isfield(SBMLFBCReaction, 'fbc_geneProductAssociation')
	if ~isnumeric(geneProductAssociation)
		error('geneProductAssociation must be numeric') ;
	else
		SBMLFBCReaction.fbc_geneProductAssociation = geneProductAssociation;
	end;
else
	error('geneProductAssociation not an attribute on SBML L%dV%d FBCReaction', level, version);
end;

