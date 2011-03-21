function fail = TestGetSymbolicRateLawsFromReactions(SBMLModel)
% GetSpeciesRateLaws(SBMLModel) takes an SBML model 
% returns 
%       1)array of species symbols
%       2)an array of symbolic representations of the rate law for each species
%--------------------------------------------------------------------------


%  Filename    :   TestGetSpeciesRateLaws.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
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


m = TranslateSBML('../../Test/test-data/algebraicRules.xml');

syms S1 S2 S3 X k k_R2 X0 X1 v_in t_in s x t k_r;

species = [S1, S2, S3, X];
rateLaws = [-k*S1, k*S1-k_R2*S2, k_R2*S2, sym('0')];

fail = TestFunction('GetSymbolicRateLawsFromReactions', 1, 2, m, species, rateLaws);

m = TranslateSBML('../../Test/test-data/l2v2-newComponents.xml');

species = [X0, X1];
rateLaws = [-(v_in*X0/t_in), sym('0')];

fail = TestFunction('GetSymbolicRateLawsFromReactions', 1, 2, m, species, rateLaws);

m = TranslateSBML('../../Test/test-data/functionDefinition.xml');

species = [s];
rateLaws = [-s*(k_r+x)/t];

fail = TestFunction('GetSymbolicRateLawsFromReactions', 1, 2, m, species, rateLaws);
