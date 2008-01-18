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
%  $Id$
%  $Source v $
%
%<!---------------------------------------------------------------------------
% This file is part of SBMLToolbox.  Please visit http://sbml.org for more
% information about SBML, and the latest version of SBMLToolbox.
%
% Copyright 2005-2007 California Institute of Technology.
% Copyright 2002-2005 California Institute of Technology and
%                     Japan Science and Technology Corporation.
% 
% This library is free software; you can redistribute it and/or modify it
% under the terms of the GNU Lesser General Public License as published by
% the Free Software Foundation.  A copy of the license agreement is provided
% in the file named "LICENSE.txt" included with this software distribution.
% and also available online as http://sbml.org/software/sbmltoolbox/license.html
%----------------------------------------------------------------------- -->



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
