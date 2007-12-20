function fail = TestIsSBML_Compartment

% /**
%  * \file    TestIsSBML_Compartment.m
%  * \brief   Compartment
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

c_l1 = struct('typecode', {'SBML_COMPARTMENT'}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'volume', {''}, 'units', {''}, 'outside', {''}, 'isSetVolume', {''});

c_l2 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, 'constant', {''}, ...
    'isSetSize', {''},'isSetVolume', {''});

c_l2v2 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartmentType', {''}, 'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetVolume', {''});

c_l2v3 = struct('typecode', {'SBML_COMPARTMENT'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartmentType', {''}, 'spatialDimensions', {''}, 'size', {''}, 'units', {''}, 'outside', {''}, ...
    'constant', {''}, 'isSetSize', {''},'isSetVolume', {''}, 'sboTerm', {''});

fail = TestFunction('isSBML_Compartment', 2, 1, c_l1, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 2, 1, c_l2, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2v2, 2, 2, 1);
fail = fail + TestFunction('isSBML_Compartment', 3, 1, c_l2v3, 2, 3, 1);










