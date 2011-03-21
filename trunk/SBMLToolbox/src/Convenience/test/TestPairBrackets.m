function fail = TestPairBrackets
%
%   PairBrackets 
%             takes a string
%
%             and returns 
%               an array of indices of each pair of brackets
%               ordered from the opening bracket index
%
%----------------------------------------------------------------
% EXAMPLE:
%       pairs = PairBrackets('(a+((b*c)/(a+b)))')
%
%       pairs = 
%                   1   17
%                   4   16
%                   5    9
%                   11  15
%


%  Filename    :   TestPairBrackets.m
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


input = '(a+((b*c)/(a+b)))';
output = [1, 17; 4, 16; 5, 9; 11, 15];

fail = TestFunction('PairBrackets', 1, 1, input, output);
