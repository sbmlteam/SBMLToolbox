function fail = TestIsSBML_Species

% /**
%  * \file    TestIsSBML_Species.m
%  * \brief   Species
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

s_l1 = struct('typecode', {'SBML_SPECIES'}, 'notes', {''}, 'annotation', {''},'name', {''}, 'compartment', {''}, ...
    'initialAmount', {''}, 'units', {''}, 'boundaryCondition', {''}, 'charge', {''}, 'isSetInitialAmount', {''}, ...
    'isSetCharge', {''});

s_l2 = struct('typecode', {'SBML_SPECIES'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, 'id', {''}, ...
    'compartment', {''}, 'initialAmount', {''}, 'initialConcentration', {''}, 'substanceUnits', {''}, ...
    'spatialSizeUnits', {''}, 'hasOnlySubstanceUnits', {''}, 'boundaryCondition', {''}, 'charge', {''}, ...
    'constant', {''}, 'isSetInitialAmount', {''}, 'isSetInitialConcentration', {''}, 'isSetCharge', {''});

s_l2v2 = struct('typecode', {'SBML_SPECIES'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'name', {''}, ...
    'id', {''}, 'speciesType', {''}, 'compartment', {''}, 'initialAmount', {''}, 'initialConcentration', {''}, ...
    'substanceUnits', {''}, 'spatialSizeUnits', {''}, 'hasOnlySubstanceUnits', {''}, 'boundaryCondition', {''}, ...
    'charge', {''}, 'constant', {''}, 'isSetInitialAmount', {''}, 'isSetInitialConcentration', {''}, 'isSetCharge', {''});

fail = TestFunction('isSBML_Species', 2, 1, s_l1, 1, 1);
fail = fail + TestFunction('isSBML_Species', 3, 1, s_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_Species', 3, 1, s_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_Species', 2, 1, s_l2, 2, 1);
fail = fail + TestFunction('isSBML_Species', 3, 1, s_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_Species', 3, 1, s_l2v2, 2, 2, 1);










