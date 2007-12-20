function fail = TestIsSBML_UnitDefinition

% /**
%  * \file    TestIsSBML_UnitDefinition.m
%  * \brief   UnitDefinition
%  * \author  Sarah Keating
%  *
%  * $Id$
%  * $Source$
%  */
% /* Copyright 2002 California Institute of Technology and Japan Science and
%  * Technology Corporation.
%  *
%  * This library is free software; you can redistribute it and/or modify it
%  * under the terms of the GNU Lesser General Public License as published by
%  * the Free Software Foundation.  A copy of the license agreement is
%  * provided in the file named "LICENSE.txt" included with this software
%  * distribution.  It is also available online at
%  * http://sbml.org/software/libsbml/license.html
%  *
%  * You should have received a copy of the GNU Lesser General Public License
%  * along with this library; if not, write to the Free Software Foundation,
%  * Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
%  */

ud_l1 = struct('typecode', {'SBML_UNIT_DEFINITION'}, 'notes', {''}, 'annotation', {''},'name', ...
    {''}, 'unit', {''});

ud_l2 = struct('typecode', {'SBML_UNIT_DEFINITION'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', ...
    {''}, 'id', {''}, 'unit', {''});

ud_l2v2 = struct('typecode', {'SBML_UNIT_DEFINITION'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', ...
    {''}, 'id', {''}, 'unit', {''});

fail = TestFunction('isSBML_UnitDefinition', 2, 1, ud_l1, 1, 1);
fail = fail + TestFunction('isSBML_UnitDefinition', 3, 1, ud_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_UnitDefinition', 3, 1, ud_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_UnitDefinition', 2, 1, ud_l2, 2, 1);
fail = fail + TestFunction('isSBML_UnitDefinition', 3, 1, ud_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_UnitDefinition', 3, 1, ud_l2v2, 2, 2, 1);










