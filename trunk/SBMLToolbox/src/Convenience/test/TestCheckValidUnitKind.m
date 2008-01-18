function fail = TestCheckValidUnitKind
%   CheckValidUnitKind 
%             takes a string representing a unit kind
%             and returns 1 if it is valid 0 otherwise
%
%
%       value = CheckValidUnitKind('kind')


%  Filename    :   TestCheckValidUnitKind.m
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


m = TranslateSBML('../../Test/test-data/l1v1.xml');

kind1 = m.unitDefinition(1).unit.kind;
kind2 = m.unitDefinition(2).unit(2).kind;
kind3 = m.unitDefinition(2).unit(3).kind;
kind4 = m.unitDefinition(3).id;

fail = TestFunction('CheckValidUnitKind', 1, 1, kind1, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind2, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind3, 1);
fail = fail + TestFunction('CheckValidUnitKind', 1, 1, kind4, 0);
