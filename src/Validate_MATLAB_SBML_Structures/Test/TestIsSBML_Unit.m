function fail = TestIsSBML_Unit

%  Filename    :   TestIsSBML_Unit.m
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


u_l1 = struct('typecode', {'SBML_UNIT'}, 'notes', {''}, 'annotation', {''},'kind', ...
    {''}, 'exponent', {''}, 'scale', {''});

u_l2 = struct('typecode', {'SBML_UNIT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'kind', ...
    {''}, 'exponent', {''}, 'scale', {''}, 'multiplier', {''}, 'offset', {''});

u_l2v2 = struct('typecode', {'SBML_UNIT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'kind', ...
    {''}, 'exponent', {''}, 'scale', {''}, 'multiplier', {''});

u_l2v3 = struct('typecode', {'SBML_UNIT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''}, ...
  'sboTerm', {''}, 'kind', ...
    {''}, 'exponent', {''}, 'scale', {''}, 'multiplier', {''});

fail = TestFunction('isSBML_Unit', 2, 1, u_l1, 1, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Unit', 2, 1, u_l2, 2, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l2v3, 2, 3, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l2v3, 2, 4, 1);
fail = fail + TestFunction('isSBML_Unit', 3, 1, u_l2v3, 3, 1, 1);










