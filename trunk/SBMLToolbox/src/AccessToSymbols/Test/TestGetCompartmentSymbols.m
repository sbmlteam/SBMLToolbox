function fail = TestGetCompartmentSymbols
% GetCompartmentSymbols takes a SBMLModel 
% and returns 
%           1) an array of character names of all compartments within the model 
%           2) an array of the initial concentration values of each comparment
%


%  Filename    :   TestGetCompartmentSymbols.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   30-Nov-2005
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

syms compartment c c2 c1 a;
m = TranslateSBML('../../Test/test-data/l1v1.xml');

symbols = [compartment];
names = {'compartment'};
values = [1];

fail = TestFunction('GetCompartmentSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/l2v1-all.xml');

symbols = [a, c, c1];
names = {'a', 'c', 'c1'};
values = [1, 1, 1];

fail = fail + TestFunction('GetCompartmentSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

symbols = [compartment];
names = {'compartment'};
values = [3];

fail = fail + TestFunction('GetCompartmentSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/funcDefsWithInitialAssignments.xml');

symbols = [compartment];
names = {'compartment'};
values = [3];

fail = fail + TestFunction('GetCompartmentSymbols', 1, 3, m, symbols, values, names);

