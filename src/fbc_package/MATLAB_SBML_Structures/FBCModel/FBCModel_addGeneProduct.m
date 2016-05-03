function SBMLFBCModel = FBCModel_addGeneProduct(SBMLFBCModel, SBMLGeneProduct)
% SBMLFBCModel = FBCModel_addGeneProduct(SBMLFBCModel, SBMLGeneProduct)
%
% Takes
%
% 1. SBMLFBCModel, an SBML FBCModel structure
% 2. SBMLGeneProduct, an SBML GeneProduct structure
%
% Returns
%
% 1. the SBML FBCModel structure with the SBML GeneProduct structure added
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

[level, version, pkgVersion] = GetFBCLevelVersion(SBMLFBCModel);
[geneProduct_level, geneProduct_version, geneProduct_pkgVersion] = GetFBCLevelVersion(SBMLGeneProduct);

if level ~= geneProduct_level
	error('mismatch in levels');
elseif version ~= geneProduct_version
	error('mismatch in versions');
elseif pkgVersion ~= geneProduct_pkgVersion
	error('mismatch in package versions');
end;

if isfield(SBMLFBCModel, 'fbc_geneProduct')
	index = length(SBMLFBCModel.fbc_geneProduct);
	if index == 0
		SBMLFBCModel.fbc_geneProduct = SBMLGeneProduct;
	else
		SBMLFBCModel.fbc_geneProduct(index+1) = SBMLGeneProduct;
	end;
else
	error('geneProduct not an element on SBML L%dV%d FBCModel', level, version);
end;

