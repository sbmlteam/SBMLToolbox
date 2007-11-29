function fail = TestGetGlobalParameterSymbols
% GetGlobalParameterSymbols takes a SBMLModel 
% and returns 
%           1) an array of symbols representing all global parameters within the model 
%           2) an array of the values of each parameter
%           3) an array of character names of the symbols
%


%  Filename    :   TestGetGlobalParameterSymbols.m
%  Description : 
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  Organization:   University of Hertfordshire STRI
%  Created     :   04-Oct-2005
%  Revision    :   $Id$
%  Source      :   $Source v $
%
%  Copyright 2005 California Institute of Technology, the Japan Science
%  and Technology Corporation, and the University of Hertfordshire
%
%  This library is free software; you can redistribute it and/or modify it
%  under the terms of the GNU Lesser General Public License as published
%  by the Free Software Foundation; either version 2.1 of the License, or
%  any later version.
%
%  This library is distributed in the hope that it will be useful, but
%  WITHOUT ANY WARRANTY, WITHOUT EVEN THE IMPLIED WARRANTY OF
%  MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE.  The software and
%  documentation provided hereunder is on an "as is" basis, and the
%  California Institute of Technology, the Japan Science and Technology
%  Corporation, and the University of Hertfordshire have no obligations to
%  provide maintenance, support, updates, enhancements or modifications.  In
%  no event shall the California Institute of Technology, the Japan Science
%  and Technology Corporation or the University of Hertfordshire be liable
%  to any party for direct, indirect, special, incidental or consequential
%  damages, including lost profits, arising out of the use of this software
%  and its documentation, even if the California Institute of Technology
%  and/or Japan Science and Technology Corporation and/or University of
%  Hertfordshire have been advised of the possibility of such damage.  See
%  the GNU Lesser General Public License for more details.
%
%  You should have received a copy of the GNU Lesser General Public License
%  along with this library; if not, write to the Free Software Foundation,
%  Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%
%  The original code contained here was initially developed by:
%
%      Sarah Keating
%      Science and Technology Research Institute
%      University of Hertfordshire
%      Hatfield, AL10 9AB
%      United Kingdom
%
%      http://www.sbml.org
%      mailto:sbml-team@caltech.edu
%
%  Contributor(s):


m = TranslateSBML('../../Test/test-data/algebraicRules.xml');

syms k s1 s2 k1 s3 c c1;

symbols = [k s1 s2];
names = {'k', 's1', 's2'};
values = [1, 3, 4];

fail = TestFunction('GetGlobalParameterSymbols', 1, 3, m, symbols, values, names);

m = TranslateSBML('../../Test/test-data/initialAssignments.xml');

symbols = [k, k1, s1, s2, s3, c, c1];
names = {'k', 'k1', 's1', 's2', 's3', 'c', 'c1'};
values = [6, 2, 3, 4, 1, 6, 2];

fail = fail + TestFunction('GetGlobalParameterSymbols', 1, 3, m, symbols, values, names);

