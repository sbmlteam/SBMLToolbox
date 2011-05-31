function fail = TestGetParameterRateRules
% GetParameterRateRules takes an SBMLModel 
% and returns
%             1) an array of Parameter names
%             2) an array of the character representation of the
%             concentration for each Parameter assigned by rules


%  Filename    :   TestGetParameterRateRules.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id: TestGetParameterRateRules.m 13259 2011-03-21 05:40:36Z mhucka $
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


m = TranslateSBML('../../Test/test-data/varyingParameters.xml');

Parameter = {'t', 'k', 'k1', 'v1', 'v2', 'v3'};
rules = {'0', '0', '0', '0', 'v1/t', '0'};

fail = TestFunction('GetParameterRateRules', 1, 2, m, Parameter, rules);

m = TranslateSBML('../../Test/test-data/l3v1core.xml');

names = {'p', 'p1', 'p2', 'p3', 'x', 'd'};
values = {'0', '0', '0', 'p1/p', '0', '0'};

fail = fail + TestFunction('GetParameterRateRules', 1, 2, m, names, values);

