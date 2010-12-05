function fail = TestIsSBML_Priority

%  Filename    :   TestIsSBML_Priority.m
%  Description :
%  Author(s)   :   SBML Development Group <sbml-team@caltech.edu>
%  $Id: TestIsSBML_Priority.m 11823 2010-09-03 11:24:42Z sarahkeating $
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


pr_l3v1 = struct('typecode', {'SBML_PRIORITY'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},...
  'sboTerm', {''}, 'math', {''});


fail = TestFunction('isSBML_Priority', 2, 1, pr_l3v1, 1, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 1, 1, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 1, 2, 0);
fail = fail + TestFunction('isSBML_Priority', 2, 1, pr_l3v1, 2, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 2, 1, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 2, 2, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 2, 3, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 2, 4, 0);
fail = fail + TestFunction('isSBML_Priority', 3, 1, pr_l3v1, 3, 1, 1);










