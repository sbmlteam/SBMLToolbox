function fail = TestDealWithPiecewise
%
%   DealWithPiecewise 
%             takes a string representation of a formula that contains the MathML piecewise function 
%
%             and returns 
%               an array of the three components of the piecewise function
%               which can then be written as an if else statement
%     
%   EXAMPLE:
%           elements = DealWithPiecewise('piecewise(le(s2,4),1.5,0.05)')
%
%                    =  'le(s2,4)'  '1.5'   '0.05'


%  Filename    :   TestDealWithPiecewise.m
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


input = 'piecewise(le(s2,4),1.5,0.05)';
output = {'le(s2,4)', '1.5', '0.05'};

fail = TestFunction('DealWithPiecewise', 1, 1, input, output);

input = 'piecewise(piecewise(1, a<5, 2), 3, 4)';
output= {'piecewise(1,a<5,2)', '3', '4'};

fail = fail + TestFunction('DealWithPiecewise', 1, 1, input, output);

m = TranslateSBML('../../Test/test-data/piecewise.xml');

input = m.reaction.kineticLaw.math;
output = {'p1', 'leq(kf,4)', 'p2'};

fail = fail + TestFunction('DealWithPiecewise', 1, 1, input, output);

m = TranslateSBML('../../Test/test-data/nestedPiecewise.xml');

input = m.reaction.kineticLaw.math;
output = {'piecewise(p1,leq(kf,4),p2)', 'leq(kf,4)', 'p2'};

fail = fail + TestFunction('DealWithPiecewise', 1, 1, input, output);
