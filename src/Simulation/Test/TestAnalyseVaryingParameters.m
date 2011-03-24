function fail = TestAnalyseVaryingParameters
% AnalyseVaryingParameters takes a MATLAB_SBML model structure and outputs a
% structure detailing the VaryingParameters and how they are manipulated within the
% model
% 
% the structure fields are
%     Name
%     initialValue
%     ChangedByRateRule
%     RateRule
%     ChangedByAssignmentRule
%     AssignmentRule
%     InAlgebraicRule
%     AlgebraicRule
%     ConvertedToAssignRule
%     ConvertedRule

%  Filename    :   TestAnalyseVaryingParameters.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: TestAnalyseVaryingParameters.m 13259 2011-03-21 05:40:36Z mhucka $
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



m = TranslateSBML('../../Test/test-data/varyingParameters.xml');

output_1(1).Name = {'v1'};
output_1(1).initialValue = 4;
output_1(1).ChangedByRateRule = 0;
output_1(1).RateRule = '';
output_1(1).ChangedByAssignmentRule = 1;
output_1(1).AssignmentRule = {'k1+k'};
output_1(1).InAlgebraicRule = 0;
output_1(1).AlgebraicRule = '';
output_1(1).ConvertedToAssignRule = 0;
output_1(1).ConvertedRule = '';

output_1(2).Name = {'v2'};
output_1(2).initialValue = 4;
output_1(2).ChangedByRateRule = 1;
output_1(2).RateRule = {'v1/t'};
output_1(2).ChangedByAssignmentRule = 0;
output_1(2).AssignmentRule = '';
output_1(2).InAlgebraicRule = 1;
output_1(2).AlgebraicRule = {{'v3+k1-v2'}};
output_1(2).ConvertedToAssignRule = 0;
output_1(2).ConvertedRule = '';

output_1(3).Name = {'v3'};
output_1(3).initialValue = 4;
output_1(3).ChangedByRateRule = 0;
output_1(3).RateRule = '';
output_1(3).ChangedByAssignmentRule = 0;
output_1(3).AssignmentRule = '';
output_1(3).InAlgebraicRule = 1;
output_1(3).AlgebraicRule = {{'v3+k1-v2'}};
output_1(3).ConvertedToAssignRule = 1;
output_1(3).ConvertedRule = '-k1+v2';

fail = TestFunction('AnalyseVaryingParameters', 1, 1, m, output_1);

