function fail = TestIsSBML_SpeciesReference

% /**
%  * \file    TestIsSBML_SpeciesReference.m
%  * \brief   SpeciesReference
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

sr_l1 = struct('typecode', {'SBML_SPECIES_REFERENCE'}, 'notes', {''}, 'annotation', {''},'species', ...
    {''}, 'stoichiometry', {''}, 'denominator', {''});

sr_l2 = struct('typecode', {'SBML_SPECIES_REFERENCE'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'species', ...
    {''}, 'stoichiometry', {''}, 'denominator', {''}, 'stoichiometryMath', {''});

sr_l2v2 = struct('typecode', {'SBML_SPECIES_REFERENCE'}, 'metaid', {''}, 'notes', {''}, 'annotation', {''},'species', ...
    {''}, 'id', {''}, 'name', {''}, 'sboTerm', {''}, 'stoichiometry', {''}, 'stoichiometryMath', {''});

fail = TestFunction('isSBML_SpeciesReference', 2, 1, sr_l1, 1, 1);
fail = fail + TestFunction('isSBML_SpeciesReference', 3, 1, sr_l1, 1, 1, 1);
fail = fail + TestFunction('isSBML_SpeciesReference', 3, 1, sr_l1, 1, 2, 1);
fail = fail + TestFunction('isSBML_SpeciesReference', 2, 1, sr_l2, 2, 1);
fail = fail + TestFunction('isSBML_SpeciesReference', 3, 1, sr_l2, 2, 1, 1);
fail = fail + TestFunction('isSBML_SpeciesReference', 3, 1, sr_l2v2, 2, 2, 1);










