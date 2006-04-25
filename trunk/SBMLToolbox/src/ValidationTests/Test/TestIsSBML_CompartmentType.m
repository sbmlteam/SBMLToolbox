function fail = TestIsSBML_CompartmentType

% /**
%  * \file    TestIsSBML_CompartmentType.m
%  * \brief   CompartmentType
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

ct_l2v2 = struct('typecode', {'SBML_COMPARTMENT_TYPE'}, 'notes', {''}, 'annotation', {''},'name', ...
    {''}, 'id', {''});


fail = TestFunction('isSBML_CompartmentType', 2, 1, ct_l2v2, 1, 0);
fail = fail + TestFunction('isSBML_CompartmentType', 3, 1, ct_l2v2, 1, 1, 0);
fail = fail + TestFunction('isSBML_CompartmentType', 3, 1, ct_l2v2, 1, 2, 0);
fail = fail + TestFunction('isSBML_CompartmentType', 2, 1, ct_l2v2, 2, 0);
fail = fail + TestFunction('isSBML_CompartmentType', 3, 1, ct_l2v2, 2, 1, 0);
fail = fail + TestFunction('isSBML_CompartmentType', 3, 1, ct_l2v2, 2, 2, 1);










