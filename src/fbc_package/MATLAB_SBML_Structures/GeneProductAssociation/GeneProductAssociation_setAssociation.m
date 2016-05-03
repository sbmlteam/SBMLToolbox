function SBMLGeneProductAssociation = GeneProductAssociation_setAssociation(SBMLGeneProductAssociation, SBMLFBCAssociation)
% SBMLGeneProductAssociation = GeneProductAssociation_setAssociation(SBMLGeneProductAssociation, SBMLFBCAssociation)
%
% Takes
%
% 1. SBMLGeneProductAssociation, an SBML GeneProductAssociation structure
% 2. SBMLFBCAssociation, the SBML  FBCAssociation structure to set
%
% Returns
%
% 1. the SBML FBC GeneProductAssociation structure with the new value for
% the fbc_association element
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

[level, version, pkgVersion] = GetFBCLevelVersion(SBMLGeneProductAssociation);
[geneProduct_level, geneProduct_version, geneProduct_pkgVersion] = GetFBCLevelVersion(SBMLFBCAssociation);

if level ~= geneProduct_level
	error('mismatch in levels');
elseif version ~= geneProduct_version
	error('mismatch in versions');
elseif pkgVersion ~= geneProduct_pkgVersion
	error('mismatch in package versions');
end;
if isfield(SBMLGeneProductAssociation, 'fbc_association')
    SBMLGeneProductAssociation.fbc_association = SBMLFBCAssociation;
else
	error('association not an attribute on SBML L%dV%d GeneProductAssociation', level, version);
end;

