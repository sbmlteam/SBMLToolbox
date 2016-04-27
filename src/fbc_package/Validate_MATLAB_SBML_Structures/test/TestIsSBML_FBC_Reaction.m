function fail = TestIsSBML_FBC_Reaction

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


gp_l3v1_v2 = struct('typecode', {'SBML_FBC_GENE_PRODUCT_ASSOCIATION'}, 'metaid', {''}, ...
  'notes', {''}, 'annotation', {''}, 'sboTerm', {''}, 'fbc_id', {''}, ...
    'fbc_name', {''}, 'fbc_association', {''}, ...
    'level', {3}, 'version', {1}, 'fbc_version', {2});

gp_l3v1_v2_bad = struct('typecode', {'SBML_FBC_GENE_PRDUCT_ASSOCIATION'}, 'metaid', {''}, ...
  'notes', {''}, 'annotation', {''}, 'sboTerm', {''}, 'fbc_id', {''}, ...
    'fbc_name', {''}, 'fbc_association', {''}, ...
    'level', {3}, 'version', {1}, 'fbc_version', {2});

s_l3v1 = Reaction_create(3, 1);
s_l3v1.fbc_upperFluxBound = '';
s_l3v1.fbc_lowerFluxBound = '';
s_l3v1.fbc_geneProductAssociation = gp_l3v1_v2;
s_l3v1.fbc_version = 2;

s_l3v1_bad = Reaction_create(3, 1);
s_l3v1_bad.fbc_upperBound = '';
s_l3v1_bad.fbc_geneProductAssociation = gp_l3v1_v2;
s_l3v1_bad.fbc_version = 2;

s_l3v1_bad2 = Reaction_create(3, 1);
s_l3v1_bad2.fbc_upperFluxBound = '';
s_l3v1_bad2.fbc_lowerFluxBound = '';
s_l3v1_bad2.fbc_geneProductAssociation = gp_l3v1_v2_bad;
s_l3v1_bad2.fbc_version = 2;

fail = 0;
fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1, 3, 1, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1, 3, 1, 2, 1);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1, 3, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1, 2, 4, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1, 3, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1, 2, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 1, 1, s_l3v1, 0);
fail = fail + TestFunction('isValid', 1, 1, s_l3v1, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1, 3, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1, 2, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1, 3, 1, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1, 2, 4, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1, 3, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1, 2, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1, 3, 1, 2, 1);
fail = fail + TestFunction('isValidFBC', 1, 1, s_l3v1, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1, 3, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1, 2, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1, 3, 1, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1, 2, 4, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1, 3, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1, 2, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1, 3, 1, 2, 1);

fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1_bad, 3, 1, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1_bad, 3, 1, 2, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1_bad, 3, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1_bad, 2, 4, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1_bad, 3, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1_bad, 2, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 1, 1, s_l3v1_bad, 0);
fail = fail + TestFunction('isValid', 1, 1, s_l3v1_bad, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1_bad, 3, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1_bad, 2, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1_bad, 3, 1, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1_bad, 2, 4, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad, 3, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad, 2, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad, 3, 1, 2, 0);
fail = fail + TestFunction('isValidFBC', 1, 1, s_l3v1_bad, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1_bad, 3, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1_bad, 2, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1_bad, 3, 1, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1_bad, 2, 4, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad, 3, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad, 2, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad, 3, 1, 2, 0);

fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1_bad2, 3, 1, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 4, 1, s_l3v1_bad2, 3, 1, 2, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1_bad2, 3, 1, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 3, 1, s_l3v1_bad2, 2, 4, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1_bad2, 3, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 2, 1, s_l3v1_bad2, 2, 0);
fail = fail + TestFunction('isSBML_FBC_Reaction', 1, 1, s_l3v1_bad2, 0);
fail = fail + TestFunction('isValid', 1, 1, s_l3v1_bad2, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1_bad2, 3, 0);
fail = fail + TestFunction('isValid', 2, 1, s_l3v1_bad2, 2, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1_bad2, 3, 1, 0);
fail = fail + TestFunction('isValid', 3, 1, s_l3v1_bad2, 2, 4, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad2, 3, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad2, 2, 1, 1, 0);
fail = fail + TestFunction('isValid', 4, 1, s_l3v1_bad2, 3, 1, 2, 0);
fail = fail + TestFunction('isValidFBC', 1, 1, s_l3v1_bad2, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1_bad2, 3, 0);
fail = fail + TestFunction('isValidFBC', 2, 1, s_l3v1_bad2, 2, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1_bad2, 3, 1, 0);
fail = fail + TestFunction('isValidFBC', 3, 1, s_l3v1_bad2, 2, 4, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad2, 3, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad2, 2, 1, 1, 0);
fail = fail + TestFunction('isValidFBC', 4, 1, s_l3v1_bad2, 3, 1, 2, 0);

